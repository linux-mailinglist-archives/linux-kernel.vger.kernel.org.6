Return-Path: <linux-kernel+bounces-523687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7CEA3DA04
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12CCF422C32
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 12:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229091F5843;
	Thu, 20 Feb 2025 12:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Gcm0WKGu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831851F4606
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 12:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740054273; cv=none; b=ra67jKIB+5WkJAZ5sPKGkpZE8iKtDWLJFiT8J/B7ni72zmLyuxyBqyyQYx90qq200/yTC4kl7mTiApbx07adWdQNMSEn5GptWlPhmKE6E2tlC8E9XlVsBg2i7w+fufHcztX5hO7w3U22Oz7vU2o6uX23ccghAyIjEJ9lbOPdX30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740054273; c=relaxed/simple;
	bh=H9JOLb25VJ1CViiik1hopte6xGG2qyu1JhXJyc7Xg8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ABZw9nedtq3YBl1S4G2IvZUHu9k83cJ2alAdgppUjVkJv9XTUAvVl1ZxdBURZmz6cR3VnspElCti2aM0GjCyEM+LgV/xI/ljZbLDgcdnFdwsReVRzyi3mCNJjfpLth/a3DLuV6OQiMm1BRvMZ/21DCwvRsPFXclrFln3PwB26E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Gcm0WKGu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB86C4CED1;
	Thu, 20 Feb 2025 12:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740054273;
	bh=H9JOLb25VJ1CViiik1hopte6xGG2qyu1JhXJyc7Xg8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gcm0WKGubC8cYKkiMOFkTcbj8ALCbbwVPfUcLOhY+KEvT9oJowhsYw2Zn0MTNc8NG
	 NNkaSd3aJ4JWdWxTTOTtgDpJwPpkCbQ7sOBTheQB/iKT67E1m8bvWS+Fnw//RlJQc3
	 hy0K3mNKm0z3jkj7mlJ1Ah0ZK4Ue7daVC9ZOmyBo=
Date: Thu, 20 Feb 2025 13:24:30 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: linux-kernel@vger.kernel.org, Rodrigo Vivi <rodrigo.vivi@intel.com>,
	dri-devel@lists.freedesktop.org, Danilo Krummrich <dakr@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 3/6] drivers: base: component: Add debug message for
 unbind
Message-ID: <2025022024-salami-scabbed-08bc@gregkh>
References: <20250212200542.515493-1-lucas.demarchi@intel.com>
 <20250212200542.515493-4-lucas.demarchi@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212200542.515493-4-lucas.demarchi@intel.com>

On Wed, Feb 12, 2025 at 12:05:39PM -0800, Lucas De Marchi wrote:
> Like when binding component, add a debug message to the unbinding case
> to make it easy to track the lifecycle. This also includes the component
> pointer since that is used to open a group in devres, making it easier
> to track the resources.
> 
> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> ---

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


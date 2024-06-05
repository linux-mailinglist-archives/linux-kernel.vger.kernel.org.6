Return-Path: <linux-kernel+bounces-202832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3E98FD1A1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 17:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8297D1F23783
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 15:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14990481D3;
	Wed,  5 Jun 2024 15:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="c7/xBj9Q"
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1D0482C3
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 15:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717601368; cv=none; b=dGqoGb1MYxUagEA6RDaiuRAq8J2L54U46u8zGfK0Z9O8wj81G/umMwAUc2HI8fDzUHM0rv2+n1BN1haPGfoYgk1EanAw+Bm/herEqGy+wJXB8C1Ed/coIvbQpuo/ep/c0iYQtNSXGcCTP7gwlLUxQJqdtJ+UNk8dT9DoAjm24f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717601368; c=relaxed/simple;
	bh=lYE4mLW4/3gTTTeblhA4fcedkm6JVBcKv/nqj5RQWbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tB44SQ3S6whyB583pBQZ2HBkrFjZc4sDLmlyprWus3vuFOBghNU1uayXDArE7b4i3nCdtnUxwN5OiyyYFDrvYrU1SGLHQEp5YrX94Bx0f7lAm4RYWYmg7ojrZpRo+mt+uoZZssBKLtnHMGbMa4yI01H7qWW21PXaR/rK3aXUHVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=c7/xBj9Q; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202406051529129795a9720fa52be546
        for <linux-kernel@vger.kernel.org>;
        Wed, 05 Jun 2024 17:29:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=lYE4mLW4/3gTTTeblhA4fcedkm6JVBcKv/nqj5RQWbM=;
 b=c7/xBj9Q3Nu7BlSuOm5AYocnULLKZkmuIpnYSMKe5F5wn173MbfZ++XL1/Jo1Cex6Qw9gZ
 Us1Ti3LM6Md+P2m3NvOFWLtN0Vbibkek3Cp+XwcW/rbtNX2gv02Gq5uOsuLPfdPdQ3sR5GXf
 BhEO/fzyNUeaE2arihgxYyQ1+/K/8=;
From: Diogo Ivo <diogo.ivo@siemens.com>
To: mpearson-lenovo@squebb.ca
Cc: gregkh@linuxfoundation.org,
	heikki.krogerus@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: treat get_pdos not supported condition as info instead of error
Date: Wed,  5 Jun 2024 16:29:11 +0100
Message-ID: <20240605152911.167179-1-diogo.ivo@siemens.com>
In-Reply-To: <20240604194056.16625-1-mpearson-lenovo@squebb.ca>
References: <20240604194056.16625-1-mpearson-lenovo@squebb.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1320519:519-21489:flowmailer

Just realized Dmitry said literally the same thing as me. Sorry for the
extra noise, please ignore my comment.

Best regards,
Diogo


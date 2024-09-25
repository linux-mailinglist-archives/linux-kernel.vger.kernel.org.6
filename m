Return-Path: <linux-kernel+bounces-339597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C18D986771
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 22:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 398FF1F21F78
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 20:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F9014659F;
	Wed, 25 Sep 2024 20:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y/PvbLx0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10671F94C
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 20:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727295085; cv=none; b=KA/K8BKh7sq7ALIyMiCJiqpI741TLWuJVPs3JF8RHMe3StXI/yvirVwrXFs1ONwMtcGNSprODlY2lL0ckJjQv+BMcl+oh5XJSBdykGgWXyXaM8SiRfRPddFjGFSwQ8cuLqQyi+ral/0kieJl9BXBtOliDyFFR3B9jS8pc2PUqC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727295085; c=relaxed/simple;
	bh=FLXD1NYiWSBUa92PidKsSNhWqJdfTOHOFvWg2USsOJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=smNwVKV+mrQxxcaiUnnWEIWKbVvA8Ak6rL+qQDk80eMRosDvydALHA7KlYD39hym185xRl4UgL9hRXP8FmxuOSxyio0x5ncnVxMcSs+hWg0euzqNith9udqm6KDMuRZNTL4PdeVTmY0uGhj5XLANGnF37zTK70YQMYiDzw+Hs4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y/PvbLx0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF33DC4CEC3;
	Wed, 25 Sep 2024 20:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727295085;
	bh=FLXD1NYiWSBUa92PidKsSNhWqJdfTOHOFvWg2USsOJM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=y/PvbLx0mG5TFfZ+wPwX30uvOwAKhFM7H0cphox2celRSeJpWhXlref6y8ekQ1wyP
	 Cs0qDsD/vDpTrQd4PaBqIvc2+ImtT86QwsYtZvIDVW9V9xYC0ONFbzqM02NvvEHfnh
	 ofaR2V3x2ynrMzro+ZNcED6BT0cyomARZayTwHnc=
Date: Wed, 25 Sep 2024 16:11:21 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, "Signed-off-by: Stephen Rothwell" <sfr@canb.auug.org.au>, 
	lkml <linux-kernel@vger.kernel.org>
Subject: Re: b4 commit in -next breaks b4 on next
Message-ID: <20240925-tentacled-porpoise-from-sirius-f442be@lemur>
References: <e4a03e2b-63e1-4247-a57e-10bcb75cf7ac@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e4a03e2b-63e1-4247-a57e-10bcb75cf7ac@linaro.org>

On Wed, Sep 25, 2024 at 05:31:14PM GMT, Bryan O'Donoghue wrote:
> Which means if you run "b4 prep --edit-cover" that is used as the base for
> your b4 series.
> 
> You can't revert 3a904d2c771115154380caaae7ffaaf0095fb88f so you basically
> can't use -next for b4 at the moment.

This should not be a problem with version 0.14.x. Are you using an older
version of b4?

-K


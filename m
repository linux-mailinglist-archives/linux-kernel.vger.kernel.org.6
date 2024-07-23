Return-Path: <linux-kernel+bounces-260227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 324DB93A4B5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 19:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E12BD2851D8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 17:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2C214A4C9;
	Tue, 23 Jul 2024 17:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mMx0VAGt"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0A814C5A1
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 17:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721754617; cv=none; b=lb//PcPR1lVhAxfSaloWcICfwFDXr7C0SeyMqYwZMDfahVHga8ChGj2P7awU1N4/SUmFA4cKCX9bfegvDLhNCjrm+Sxra8JU9bvCmluPYDI40O45PwoUcd1xyMHRdcLgh+O8tTp2w91PUn8f/UMoaBNbhAZXo/+e1utgrfpgJK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721754617; c=relaxed/simple;
	bh=svR8y78lfBq3qZtNe+9eUZ+m77MqcRxgyK9WiUS8rqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TOQaEWd0jJVT0wR03AojAqwXQ39ssXEsbWpjhK/87H7QbpW2dKw/7jIxwT2HSL2Tk9OOk4IoCfoDuc0y4vAAHMrypxES4WKdoAxuC2vvoGTLBEa+osaoE3kzYFsKkVjKRdQSzLqJolxt2WNgdEUIRjNE5NeRQX+zn6ut338eJDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mMx0VAGt; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fd90c2fc68so8385645ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 10:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721754615; x=1722359415; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mfXh0e5qvlr9V94xYRTDIYHCRmA4p3PKN50LXFEptwo=;
        b=mMx0VAGtqa1uRrKheiCo+sDClgIafBvJNNEmh2Ap+e/I3aI9WbBaNcIk3cbFvUkwGe
         BksSYGTGn6goJzRsv5gyMKnW2HwPfuw9/dEe5wyKugKLjXZ2aZwEslkfpY6wmWMqgP47
         Yu+W8a+yBimBbHHnBg8DSp6Y/vntx0/61twZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721754615; x=1722359415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mfXh0e5qvlr9V94xYRTDIYHCRmA4p3PKN50LXFEptwo=;
        b=cSpe5d3C+/neKAfLrMXe4WwpOkk+A04hKawU9Y8hYQj4n2pteiVzGHxfqJ8sTFylX6
         FyJn0kxPgvDmNvuhEKEhPQJjiPmosBG/yihO+XOtVDK6m+O+knEd7EVSHoRNv4LbkLHk
         WlzGy3J+//0zZW80MSXHjdi9LH1GDSr49iYUXfGbKxsp3VGK1+7P4fX+1A3ztD6sOg/c
         AlVdU80UQzdb+lozYnSEqfwx23Zi9xLnbO9YJ0RY6iDpmltcf3n4SUrv9jjgPTbDevC7
         MEGmaRlf+hIs8FOP66IG648qO4uSgBZuBGFyl985P8BDXPzFlswu1fThfo3TGoLOe3bX
         KX8A==
X-Forwarded-Encrypted: i=1; AJvYcCW5l5z2OxLA8OKwThtlT89kwUEnzFuYtKO0HzVnOtMpIoAHwVT+CnY6QAncXLA7zJmFjr1XPbIAR9Zl3LlHUTTO4QlXM2YjGL5fWx+u
X-Gm-Message-State: AOJu0YwaIjiXb6PxIdFiga6azILtRU5b/s/h/G8RFj/guEDIC0Aa1Dry
	cvZv1fBVM3JI8macC4iHVa0YRBDwfEfDFivgDsvEN0YfBZ1FT6F4hylbrzmzNg==
X-Google-Smtp-Source: AGHT+IHvniJlM77jc39PhRZdLCQJ2B+vWgh38JfugkBonmrTqOIcCFDNiTRqD6b0b4xRovDi/FP/Kg==
X-Received: by 2002:a17:903:2442:b0:1fd:64ef:da17 with SMTP id d9443c01a7336-1fdb5f6b603mr37015895ad.41.1721754614633;
        Tue, 23 Jul 2024 10:10:14 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:3be5:f451:a5db:11b4])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2cb772c20fbsm10440114a91.10.2024.07.23.10.10.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 10:10:14 -0700 (PDT)
Date: Tue, 23 Jul 2024 10:10:12 -0700
From: Brian Norris <briannorris@chromium.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>,
	David Lin <yu-hao.lin@nxp.com>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] wifi: mwifiex: fix key_mgmt setting
Message-ID: <Zp_j9P6jTzMpCqO-@google.com>
References: <20240723-mwifiex-wpa-psk-sha256-v3-0-025168a91da1@pengutronix.de>
 <20240723-mwifiex-wpa-psk-sha256-v3-2-025168a91da1@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240723-mwifiex-wpa-psk-sha256-v3-2-025168a91da1@pengutronix.de>

On Tue, Jul 23, 2024 at 09:09:58AM +0200, Sascha Hauer wrote:
> bss_config->key_mgmt specifies the AKM suites that are usable in
> hardware. This variable is set to specific values while iterating
> over the advertised AKM suites. This means the final value of the
> variable depends on the order of the entries in the AKM suites
> array. Instead of setting the variable, just set the relevant bits
> in the key_mgmt bit field to make us independent of the order of
> entries.
> This behaviour is derived from the downstream driver that does the
> same.
> Also, set bss_config->key_mgmt to zero explicitly right before the
> loop. bss_config has been zero allocated by the caller already, but
> do so again to safe the reader from following the code path.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/net/wireless/marvell/mwifiex/uap_cmd.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Acked-by: Brian Norris <briannorris@chromium.org>


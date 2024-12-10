Return-Path: <linux-kernel+bounces-440510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A05F9EBF4A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 00:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0E24168ED2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 23:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43192211292;
	Tue, 10 Dec 2024 23:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MpIf3+fX"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02401BCA05
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 23:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733873543; cv=none; b=mITAkz8gfvxJX1+TQqj1CwbwvC+s2MQFhEnLBuuGxciPMVhvObxAUth9/9/DaGJi2mtJesfDJe40aHFpDeotuRnt48q+yOiKghOEhbtfXkix/nXo4vK9VMtmOj8BGIKk7jSyCOAwBDDtVPn4rxfecqcNkOk7yGNJmtEWFaDcQOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733873543; c=relaxed/simple;
	bh=vEmcpdD6utgxUgH1JFTnbgHAMBxNLl0W/XKJsZ7+bJY=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rZ3YmYHuI/qRD5hSg+HkNB9eMGxh2myMyf4YJwu66CbyBMQ3CV3z2ka0ToMAnEd+wWye5IFDr2936BM/zrYf34irKICwHFWPgJrMJUSHwp1tT2BBjL5fLmy1CgFruUPZkXZJj/+nIn07ovWq2eKPjDu+t1Fu3AHnBjSI9rQ8rZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MpIf3+fX; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6d884e8341bso44593506d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 15:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733873541; x=1734478341; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lNSsVv7KU155VhgXVtB8Aqx0lbO0HbiZIJczhBckudg=;
        b=MpIf3+fXDgNsO2C5G8T2cIkPAogmtlPzATSVuHKxcM4mJqQb6xU7MlgzZdSVQY0YHI
         mQUe73ZeZyAvBRX+2yipHA6xWhx8/FlfbDGd4PXBDqMPveijcwGnWyLIGtm1d3+Hdglb
         Ts6ONYnKSsq+6AZ14JnoowBRsghu/9ADEmByU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733873541; x=1734478341;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lNSsVv7KU155VhgXVtB8Aqx0lbO0HbiZIJczhBckudg=;
        b=UmHNNzRiBsWF0jnBfKcFCCrrBjO7U/5ibRSsdJ14z8thPgmotH0k02hrm6UOLAW2l9
         1c0i/Kz8TxXf3oPzvvkITiTazQMP/Mjx0QmSWlZLpb9Q8BbQBFugt/0uMlwH/IRPAQ+W
         aSknNkWkZxl2ZwNGDRpmVF0fD4pFqE6zkqcPK5bBz70O0XB1uo7XPjteLnDkrOt5ie0C
         HGJmNri7QCkOTGbzietdjuMrLDpJ6GfbT2IpPJ40JP6hfVkRsAdpDtgLiz7b/6LH33+H
         4s5wkSNH5BtPisk0c/PFgvRtD/LbuPYQpcldKpJEDvMx2jcYjVvmYhIOTQzmpRqUH51L
         o+2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXsDQnJbwNWYXRGn0fNYJWrK1XCcalslSacovRL1nptNqvuEHAg6IW8zcNj3uA0+Osnj91BmTrqxzWTAKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbuNOv2Zmj8P9XCfwtdbKs0dmCVCK785sCSsLxsEvHtl9Bf/NB
	Qi8KdqN3UrNecw9xHH0nk8HOMshjdLLgAbxWDfsZ9nKDZkkwKmfdOTPw0QKyl8kx0fLr3r/swRr
	K7vGHmdgPLPKE6kxvNPUt1zqQIJYLFMGZPl0O
X-Gm-Gg: ASbGncvPF+ntLTfJc/OsoPdUSvFbfTYuunLV24WF5fZksldqn6LlRQPVEHU8NXd3TFw
	IfLvTK8NaBxWoitxAztTuz0kemkyIXjIf+ld5WDd4acyLJqBsgDbs0z2bATcZKh4=
X-Google-Smtp-Source: AGHT+IEGWmx7S4JBYGfWQOD65vmgEAAhQL6zFTlZ/dCNDZNEubtkbW5GNRN0pNFA0cDECucV/k/9y1lQVSBoFQBpEXM=
X-Received: by 2002:a0c:c68f:0:b0:6d9:353b:a8e9 with SMTP id
 6a1803df08f44-6d9353baa68mr9577246d6.15.1733873541103; Tue, 10 Dec 2024
 15:32:21 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 10 Dec 2024 15:32:20 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241206153813.v4.4.I083bf9188947be8cb7460211cfdf3233370a28f6@changeid>
References: <20241206233830.2401638-1-abhishekpandit@chromium.org> <20241206153813.v4.4.I083bf9188947be8cb7460211cfdf3233370a28f6@changeid>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.12.dev1+gaa8c22fdeedb
Date: Tue, 10 Dec 2024 15:32:20 -0800
Message-ID: <CAE-0n52AG8henLkzAyO112pBmNAskcC0SXKFNCyQQ3MG01xkGg@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] platform/chrome: cros_ec_typec: Update partner
 altmode active
To: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, chrome-platform@lists.linux.dev, 
	heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org, 
	tzungbi@kernel.org
Cc: akuchynski@google.com, pmalani@chromium.org, jthies@google.com, 
	dmitry.baryshkov@linaro.org, badhri@google.com, rdbabiera@google.com, 
	Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Quoting Abhishek Pandit-Subedi (2024-12-06 15:38:15)
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index c7781aea0b88..e3eabe5e42ac 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -676,6 +677,16 @@ static int cros_typec_configure_mux(struct cros_typec_data *typec, int port_num,
>                         port->mux_flags);
>         }
>
> +       /* Iterate all partner alt-modes and set the active alternate mode. */
> +       list_for_each_entry_safe(node, n, &port->partner_mode_list, list) {

This can just be list_for_each_entry() because the list isn't changing
during iteration.

> +               if (port->state.alt != NULL &&
> +                   node->amode->svid == port->state.alt->svid) {
> +                       typec_altmode_update_active(node->amode, true);
> +               } else {
> +                       typec_altmode_update_active(node->amode, false);
> +               }

It could also be shorter:

	list_for_each_entry(node, &port->partner_mode_list, list) {
		typec_altmode_update_active(node->amode,
			port->state.alt && node->amode->svid == port->state.alt->svid);
	}

As far as I can tell, cros_typec_configure_mux() is called when the HPD
state changes. We'll iterate through here unnecessarily in that case.
Can that be avoided somehow?

> +
>  mux_ack:
>         if (!typec->needs_mux_ack)
>                 return ret;


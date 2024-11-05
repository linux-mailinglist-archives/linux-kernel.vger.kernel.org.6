Return-Path: <linux-kernel+bounces-396260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CD29BCA4D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 11:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A09491F236B7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 10:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7204F1D1F57;
	Tue,  5 Nov 2024 10:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUInRfQ/"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A1E1CF7C9
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 10:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730802085; cv=none; b=FDzZqU4x3B6WoaOg9lDVlKtnpeQ25QJksRCamMPt0EUcY+3DQqNMVpsmOVehGV7ZZCKkacS1mIbndP036avgV8QlJc34D2XWYHVvsr65H+OXZRh3GTXOZCMOyu7nbJARfQNR0kVCx/4G3wiHgBnVguTob7IQJsxH0NI2JeRsTrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730802085; c=relaxed/simple;
	bh=7johmFIxlLMPLSJqq5TydQDo3koGyzHVL0vN4smmk5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oCiS6LiI8n7y7uvnpgMZy2UuvO0I137D1EbTCZTliIt0a6C6KA+YKSEKe3Rn9fQpvflti+VbvUzLadmnNU7mwy3tlkwExTaba5POQobbueCG/ADHb0R2e5jVZEGTqmgTv0KlvtJWe2ORMWPDa51vBDOITZ3jgYMhiu20xeu2g7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OUInRfQ/; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-72061bfec2dso4856956b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 02:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730802084; x=1731406884; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7johmFIxlLMPLSJqq5TydQDo3koGyzHVL0vN4smmk5U=;
        b=OUInRfQ/cA+Qt/XQ6y+dZZCbmsugNYoOURpi0El0yL14ABUXnz2WiyZvEZqGlu/9Nw
         em7ww9BQNczzGWRsibzT6mWPHMYZQi0DzQtRM4ltf5kZlA1cv4EaThFfAEwql41P+yH0
         Ki8iKpUZ0Kmzer6R8fZwKk5v7nCLaJN0NBemGqZofiGRemCUdo30T4+ABRz9GSfxReK1
         Hs6TCzpSFbHgXqEbDsCSpl/1mH5Trxs2EE3bTAdoTkDS+I33d4pZ/8aL0A/pBs84pB/F
         7UvkE4WEpdjQTUwY49xLc6EUed/3MfTc6WjEBhQEgQPFjuFNXpAI3kQzgJr9ZWMR3O7w
         CoBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730802084; x=1731406884;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7johmFIxlLMPLSJqq5TydQDo3koGyzHVL0vN4smmk5U=;
        b=hQpCGpcKBFZ1kA/BIxLNB7dX5/nwNjoDiUM/FqGeMMV1I3DeF3pY3UdVdUGUL7oXLK
         T/OjKpnr22FwS4dfX6OMbrT1sfzTWwUaOh8mpsIOn3uoj00JbE6G6xihtL33YWg3puqv
         jKbT2//ASzjsPZqOQ9pC4aL2uuTShjRx5dS4nf2jftoKPHb/T5E8fLEFqUYVN9BS5sRr
         6Z8qE1oQmtrZD0Vq9K6vIj7KgjAUeyfaf8B0iF1N91zpJniLNfKjsqhR+SBAqpSEQUCB
         uQenOJH0ICiksO8tgyIxsndl+aaxnnX5hJRZtPoRlzRCeVWd4u4lcxSMmPX+yrItQwmp
         IiYw==
X-Forwarded-Encrypted: i=1; AJvYcCXRZ0tGORhHE4jqJ03tbl1aceea+GjrsR8CIXV36LyVVSMiudZFGiwHBQ9Nx8gh4d6gUP6v84IjjFw/b0U=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx3wk3WNvWYK16AZLtxsFVD/Syw0SF1iEbLTolEtx9/m2VMPVM
	VXxB1aG3LJ+fLsPLAvqFad+bpprnAHUV/AndArZWdKK9fDxyJPwC89HJuamfRws5t1ZNQXN+4v/
	9PplP6AhL5KjEDFJwcqBlzLOlLYd97l4B
X-Google-Smtp-Source: AGHT+IGbd1N33EFPPngiyV0kWvChfD3xYpzmCqXRcDRgBnf1Ooc0ARy5UKUi+cbzUnCCAiKwcTZRwKSDCVwbJyRn6tM=
X-Received: by 2002:a05:6a21:6d8d:b0:1db:eb50:abb0 with SMTP id
 adf61e73a8af0-1dbeb50ac23mr5158105637.3.1730802083687; Tue, 05 Nov 2024
 02:21:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241102022204.155039-1-gye976@gmail.com> <hdffht6z6a6dnap7kpbg6w5hyiftgahpiyhidvgga4qjeiw5xz@wu3ca5tvfj3l>
 <p3vspkvcm7nq3gankpblloudrumenpcuflhu5fpdse75kcyyk6@w7adi7togz4j>
In-Reply-To: <p3vspkvcm7nq3gankpblloudrumenpcuflhu5fpdse75kcyyk6@w7adi7togz4j>
From: gyeyoung <gye976@gmail.com>
Date: Tue, 5 Nov 2024 19:21:12 +0900
Message-ID: <CAKbEzntS731PtOZ7iSvC8Y5XEBaFqG5TEciXQe2EiqWOv85Vdg@mail.gmail.com>
Subject: Re: [PATCH v4] drm/xe: Fix build error for XE_IOCTL_DBG macro
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> there were some checkpatch issues about mixing tabs and spaces. Next
> time please double check the checkpatch output. I also reworded the
> commit message a little bit to follow an imperative mood as outlined at
> https://www.kernel.org/doc/html/v4.10/process/submitting-patches.html#describe-your-changes

I'm sorry for not being more careful, I'll use a script next time
instead of doing it manually.

Thanks,
Gyeyoung Baek

>
> Applied to drm-xe-next. Thanks.
>
> Lucas De Marchi
>
> >
> >thanks
> >Lucas De Marchi


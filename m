Return-Path: <linux-kernel+bounces-425884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AAF79DEC2C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 19:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B78C163AF6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 18:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B9A1A0AE1;
	Fri, 29 Nov 2024 18:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X+o/JSJL"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF5B1E489
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 18:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732906067; cv=none; b=TJA2g7Q1EyhkoET5XEVaO57aMCsmSp2DOAIVzBf+FYThNrEuZkqtUlKm2/4SY6qtZ7mwWmuFFQC7HFIVAo32ECOml7qSowN7TDaWZPQNU2TBWeS9NlVtnCtqv278onY1tTOd6APRHNBKwld2OtXIatoi/BOjf7KFEPUg/2YOfbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732906067; c=relaxed/simple;
	bh=yzFFrdXn8dr9euF4LM4kEvUL45wKK7RQ8v2pkms5H6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=azY6m9dhyMctCBSoOtWC1mxeyUo8L4NZeUAaXPPEteZc1Ncj6XeZ8d5B3eneP329jq7ZfAZTv7+B3Gmxz27ewKpvD6oXtCl2tlystxBuGPgAWLfoHmOKIlUTP5mrYBD+itUpryDjzSvokeNtux5qSvttYAHPIS6cyECAfZQK6a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=X+o/JSJL; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21263dbbbc4so21002065ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 10:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732906065; x=1733510865; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KcVxSp/SGlyLOWsY0V+J8c8oFuDtTzhTcOpyJE61Nhg=;
        b=X+o/JSJL91yGE/aUPby9QmPrTl2N8pDZMd+1CfYncPd/vT939BvlDoGRu5LM3l4mOL
         u/KKZYS58j78Ewz+CqVq5sEP3RVMFZTTdsJ1IW45AAttWW87mlhgw3SiImEbpRYsyQnR
         qwGDkPORTOfkBl1kiigPjFo8EXumHix3HvN/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732906065; x=1733510865;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KcVxSp/SGlyLOWsY0V+J8c8oFuDtTzhTcOpyJE61Nhg=;
        b=PO/JSbkkQAtYCFsM6p6SkitN7uP3WCfBOfqQmtHrFN4mVTuHOgcnbZbnGdMa/eR6L3
         Q4m2U4sw/8+umS6D+NLpeNieky7aT3Pbr4rBJwOCZWt8of0vfgK3Pk9NM+pJKtr77GBt
         vnQt5zkFTqUVbQc6OZXaqyiEATm+Q7lZTETrEIQCnF2PISF5N/lOGjDBzmyH9/ltwo5c
         iVhXWh3Y8ndRW9S2PSw5JhNN258isU+E3tg2ei95vrNE+2nsirZ8EKPdWWOpuG2FfzWM
         Z926b4BCM8EV/8TmL4//s/W4gKAJUB/dxlhw/2ep7DsCN5i+R+IjZAqULRhpbkAVc01O
         3AGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXf7Uqz2xzLRXP+OGmP/PLoNefLXBj3fXXc5upJbwstDv0ZcUmUKx1xLRAVsLvF06ALZ7BqQUtgOC1sWw8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa1bQoA9gaLRzzlHtg2mnEJM9k6xZonZZRucNomsHh0jGSzAaR
	cp8ipl2WcPAgHQ84F9bj7hiwsV/KRiMHSJ7Szu4W8M6T/orSuYirfVO/Owc/FBNJi9hhDspoJrA
	=
X-Gm-Gg: ASbGncv5rBfSUEfrzP/bjmv+2fdXFALw6hBpkysym3Co2wu27tE/YuWA2EavtIQ1Gr1
	VDr60IwSA5YhX133sZ4p8XA3z/bAIhrYia0q07yNXkZOCWKYMtLw5RO7ezm65+5UVCI/2ichHku
	XY9a6lwWwtLgrSAS2kkRo9x3eG0Qb6+ZkulUPvCqkN/LQV0ekGkfqxwAcJXPxIXYHVYp1Pg5SCS
	00hlKCh4gAUs1hNd05QigXelKO0JRIiEw+zkehCn68Pouku+/jdujUN+NyIZFv0p/zhISBGtHFG
	SAPhFWKARxSL
X-Google-Smtp-Source: AGHT+IG39EnN9N6auHElaEaVmTRjxn5sOgUmbzMRrthoI1B4spJZ8LuDbM5iO249KwJojLhM34lOeQ==
X-Received: by 2002:a17:902:ea08:b0:212:63db:bb15 with SMTP id d9443c01a7336-21501b593b5mr193389855ad.38.1732906065329;
        Fri, 29 Nov 2024 10:47:45 -0800 (PST)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com. [209.85.216.42])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215219acc0esm33736105ad.234.2024.11.29.10.47.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 10:47:44 -0800 (PST)
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ee67e9287fso570366a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 10:47:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUXNTL5fk+Dd+P2p3ZyoBL27y2Ns8fPnqlmefoLrCIJqiR2Engek2tn5YRO4WuI3qTapbUliDyMHHbSJ+o=@vger.kernel.org
X-Received: by 2002:a17:90b:1fd0:b0:2ee:53b3:3f1c with SMTP id
 98e67ed59e1d1-2ee53b3416emr5720571a91.5.1732906063311; Fri, 29 Nov 2024
 10:47:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127-uvc-fix-async-v2-0-510aab9570dd@chromium.org>
 <20241127-uvc-fix-async-v2-2-510aab9570dd@chromium.org> <20241128222232.GF25731@pendragon.ideasonboard.com>
 <CANiDSCvyMbAffdyi7_TrA0tpjbHe3V_D_VkTKiW-fNDnwQfpGA@mail.gmail.com>
 <20241128223343.GH25731@pendragon.ideasonboard.com> <7eeab6bd-ce02-41a6-bcc1-7c2750ce0359@xs4all.nl>
 <CANiDSCseF3fsufMc-Ovoy-bQH85PqfKDM+zmfoisLw+Kq1biAw@mail.gmail.com>
 <20241129110640.GB4108@pendragon.ideasonboard.com> <CANiDSCvdjioy-OgC+dHde2zHAAbyfN2+MAY+YsLNdUSawjQFHw@mail.gmail.com>
 <e95b7d74-2c56-4f5a-a2f2-9c460d52fdb4@xs4all.nl> <CANiDSCvj4VVAcQOpR-u-BcnKA+2ifcuq_8ZML=BNOHT_55fBog@mail.gmail.com>
In-Reply-To: <CANiDSCvj4VVAcQOpR-u-BcnKA+2ifcuq_8ZML=BNOHT_55fBog@mail.gmail.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 29 Nov 2024 19:47:31 +0100
X-Gmail-Original-Message-ID: <CANiDSCvwzY3DJ+U3EyzA7TCQu2qMUL6L1eTmZYbM+_Tk6DsPaA@mail.gmail.com>
Message-ID: <CANiDSCvwzY3DJ+U3EyzA7TCQu2qMUL6L1eTmZYbM+_Tk6DsPaA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] media: uvcvideo: Do not set an async control owned
 by other fh
To: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans de Goede <hdegoede@redhat.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>, 
	Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Before we all go on a well deserved weekend, let me recap what we
know. If I did not get something correctly, let me know.

1) Well behaved devices do not allow to set or get an incomplete async
control. They will stall instead (ref: Figure 2-21 in UVC 1.5 )
2) Both Laurent and Ricardo consider that there is a big chance that
some camera modules do not implement this properly. (ref: years of
crying over broken module firmware :) )
3) ctrl->handle is designed to point to the fh that originated the
control. So the logic can decide if the originator needs to be
notified or not. (ref: uvc_ctrl_send_event() )
4) Right now we replace the originator in ctrl->handle for unfinished
async controls.  (ref:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/media/usb/uvc/uvc_ctrl.c#n2050)

My interpretation is that:
A) We need to change 4). We shall not change the originator of
unfinished ctrl->handle.
B) Well behaved cameras do not need the patch "Do not set an async
control owned by another fh"
C) For badly behaved cameras, it is fine if we slightly break the
v4l2-compliance in corner cases, if we do not break any internal data
structure.


I will send a new version with my interpretation.

Thanks for a great discussion


Return-Path: <linux-kernel+bounces-170103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9458BD1E8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 17:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19AB028573C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 15:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7837915574C;
	Mon,  6 May 2024 15:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O0hoCuYC"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4914315572E
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 15:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715010903; cv=none; b=EbpoilF4m/mXi0Z26hL9c25EaisrIaeSkWRt2h/dTGCTAXIdltMLz3CVrShJrxSh1GwdGbzQVK2KGzL1Uj2QESZOpHvrxHsPWo/2Dj2radLD0Om5pnyMjklVT0YBe+RoI6Hn5zn9WoGT5/zjOJ+tKgXWoGdLfR4aYxIStJgS5KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715010903; c=relaxed/simple;
	bh=jP99ie8/JjeXfuXOZy5e1iJKvfjTb7kt+yA1100I5K0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZL4OhuyWU59RZMUnnH6SxfglgWOb6vLwOu+oDk284FSP0hv9N6u2774/qKKThl6AvKIhB5IrT1tOoHuvDh/fSu85mUfH4+P+Q2GjPKZt/ZotvbwcjQoeC6BPvxdXNVLPxHiX4msDK4JXOyAU4r1LImhV/WAgPS3vOcP2NW+8ibY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=O0hoCuYC; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-43d2277d7e1so6633131cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 08:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715010900; x=1715615700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jP99ie8/JjeXfuXOZy5e1iJKvfjTb7kt+yA1100I5K0=;
        b=O0hoCuYCkAYnvh0yB8JLQDuKogX8asGZVUPxmH+dzCBDcbHwwmaHcqrtyTUVALFA/b
         hdC74GQY3NbkE33qzhhyBpwiQLJVfDaeGrA4MMH/QEBT/PUhc0FaKa0BrPLJfTL4qeP0
         YZZ1qnJK770Ur2wZfbD7Sj56KUjM9oMjScwG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715010900; x=1715615700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jP99ie8/JjeXfuXOZy5e1iJKvfjTb7kt+yA1100I5K0=;
        b=qjp2Pgc2MFb1dtOV/842JTp2zYEcVKH4WPeieJtO2Bnx+4V/FteuvkM/U8YIGXeZSH
         VxnCM8/dRxYShwlp9MD2r2FEcxqsfvm8JZLzCMMAqszl0MGzJ1OSOLbrvqQ1Ikasp2xd
         PfY/vh4nSmqEISoG5MkO72R6qF91uPeyTkfZJYSWKRslM37KjQPrFHl/J7YphjIXAV9o
         2JrWwPibSjwot6+PdOBx5nEFRs1nDA2ghLPuUd+XzsitM4li78mAURKKeYR+I39KAfq4
         ZsI0debHhfOMiP6o5AsgoD45ACZWZ8QshEYDLTG9cp/LU+3F6FsZEYgZ0dJpFn7/RHSj
         JiIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbdSTSVn3bRdMWUHaSUpaLk4i+XMfUishOfHBS0VAWcSKUO4ibmEmKMuo6oNXx+zxQQ5rn27ODJAVWU25Mh7t5a151i4HZUf2kk3wa
X-Gm-Message-State: AOJu0Yz9c7ZtSfn30bsMeJB28dwyVC67LxdSeZPCLVcq7hshVbnvlmFD
	YSQh+4V34LUoPBm+yxuDaCiVKKBWzwHcQgMfZBnu25JqOAaeeWGGFlcrvGPO2p2R3tDVu9cQ8kU
	=
X-Google-Smtp-Source: AGHT+IE5UX5dksJlknADGQ615NuWszlSkilQuDhe+j45mOt3qOkfkYvghUuaei5Cxu6A4DfI1WXJAA==
X-Received: by 2002:a05:622a:1ba0:b0:43a:c243:86ad with SMTP id bp32-20020a05622a1ba000b0043ac24386admr12277984qtb.0.1715010900134;
        Mon, 06 May 2024 08:55:00 -0700 (PDT)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com. [209.85.160.177])
        by smtp.gmail.com with ESMTPSA id eq18-20020a05622a5e1200b0043abd262cc9sm3022902qtb.83.2024.05.06.08.54.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 May 2024 08:54:59 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-439b1c72676so687241cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 08:54:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVn3J7RyIo6012W4zqNMjSlP1IETlZAfBKY7Mnh4arJoX65xt/Rz4vXz3u1/ajRd07zxqxFXZKzF27iiBn5fMy41gpqjH1yrYr2TSb0
X-Received: by 2002:a05:622a:514:b0:437:c89e:245b with SMTP id
 d75a77b69052e-43d087971dfmr4116421cf.15.1715010898305; Mon, 06 May 2024
 08:54:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422060811.670693-1-xuxinxiong@huaqin.corp-partner.google.com>
 <CAD=FV=WRLLuOkCJeM6RdAb6xLN-cPH+hfWbOv9-LujB-WMGEFw@mail.gmail.com>
 <CAGoogDB-mj8_xu04w3V2ZxOBTWoXcPKrVR1NRt6BFcpjHX3-7Q@mail.gmail.com>
 <CAD=FV=WwsR9e-ZXJRY11FvdUZ66YPy9vqmY_=sGDw5Wqk1eV3w@mail.gmail.com> <CAGoogDBCzfKwkAA-VAs3_Cdw_4oFO94mt7yjy47Sp2RAtqtPxA@mail.gmail.com>
In-Reply-To: <CAGoogDBCzfKwkAA-VAs3_Cdw_4oFO94mt7yjy47Sp2RAtqtPxA@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 6 May 2024 08:54:41 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WYiD-BUpksBnZrkWvORepZqtaAvm5645X-_oJPea0s0w@mail.gmail.com>
Message-ID: <CAD=FV=WYiD-BUpksBnZrkWvORepZqtaAvm5645X-_oJPea0s0w@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: Add panel CSOT MNB601LS1-1
To: Xuxin Xiong <xuxinxiong@huaqin.corp-partner.google.com>
Cc: sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch, 
	hsinyi@google.com, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 23, 2024 at 6:55=E2=80=AFPM Xuxin Xiong
<xuxinxiong@huaqin.corp-partner.google.com> wrote:
>
> Hi Doug, thank you!
> We had reported this info to the CSOT to correct the vendor id.
> If they confirm to fix this with the same product ID, we will submit a
> patch to fix this.

FYI, "top posting" like this is generally frowned upon on kernel
mailing lists. One such reference about this is [1]. Some folks are
very passionate about this topic, so please keep it in mind to avoid
upsetting people in the community.

In any case: did you get any response from CSOT about the improper EDID?

[1] https://subspace.kernel.org/etiquette.html

-Doug


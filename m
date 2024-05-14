Return-Path: <linux-kernel+bounces-178346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 675128C4C53
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 08:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AF0A1C20ABA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 06:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E224F9445;
	Tue, 14 May 2024 06:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g5DNN69z"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4139D4C9F
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 06:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715668213; cv=none; b=XfkE3WN83bwZnxo6TBT45n6io9mrbZexWYoVzJX0VKiGiI6Yk2MweHJWMYBD7qA6skqkyOEvUxXW2g1GW8BoV5oJR09PmYczKG86C0nMq6XlezgyKZg7dwNGzVzSXVqEu2G6p9ZTS3NE4jL/GVgakpFIDVkFMqyczEKi8n99Rqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715668213; c=relaxed/simple;
	bh=ZfAjRDouTO7ZvYghB+NJtnhbR2ZdJwmxgXE8P3wfpQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i03ETR3Spcf4/bwJrpOcgtzr2xJbkFdfrbMtT8aBokvAnPTaukZP3FZZ4wSI1QFuBuZnm00X2Xq5YolQ+R4DQKLi1qUdPg4Svup7p9UxtKHF8h/g+9eCMsO5u9QL2h6HSeHLdexRYtj4Xbmf/IhTHLZARNhkYBj5SVcffW/20DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g5DNN69z; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-61ae4743d36so51858507b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 23:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715668209; x=1716273009; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RL/HT373iFNB5/gmrPBbQbaIWBxFdiHHF2SpPtkNj6E=;
        b=g5DNN69ziRlus2VeNnifNs5kjD9k5PmggkgQY0giZsCWMvS6W/onDv5rPWHJvV5y29
         J89koFeZjn57bDbv56DRTcH/gFV/HvOthC7xvf70w95CP+dIC4IG3n+iH8oCfzNn7keS
         0TTbNKrv3MVEsnoPWHGclVTPk9B0nR/Auj4+t2A7zdiuHGEGQHX3tZziMTEgvmYnoETX
         +buCp+6EskM6IyF6nzoyxO9UNAEIHQIFYTMliQl7OSJHQIGq2hBAUj9IIwtUga3+KQ71
         /SllDw4L3JCKbpLrBHmU1xqmCj2htLIGrLNLgPASku0taSTAhh3zn2zLgtCf03uz2z6Z
         S5qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715668209; x=1716273009;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RL/HT373iFNB5/gmrPBbQbaIWBxFdiHHF2SpPtkNj6E=;
        b=qhfqdbzzP3QgMMPRTETmICGMGLce3nqxxoQd6TPdaak+4o3POahgUUzvv5AHaAKefB
         nfr2MYww2FwNz9+g6/FzmYBAtR6MBJAqlFoRsxOqmrFk1SoZKhd/+eCvCPWREZlfq0Ne
         DW+ZNWPc/CVfgRQyZYQ3WVtyKPIfWsZaX0yibQ9mPf9OcRH8eQxZ+IT+5E2KpT1i1qvE
         Olq1HsvYsEzfaZ9odA0OFHH3P8+VAPmf5pnuiwmbc1RzUSqRHRomdGao1JnEPc3wkIlk
         A+lgcI9U+CHgCk7xTgqZTp2+Ot+v/o73cS7gNzq6NAbkAB7OJfrULSep4F4WZu6Xf44b
         BYHw==
X-Forwarded-Encrypted: i=1; AJvYcCVgd8fX9s6iOYdaDeGKRWgnCNPZSDl1IS3XbNGD8vQrt73nnPe1Q3aXeEMxzYav4cRCGlmd8v8ZLH6Rn0KO14QZOZN4zG6G7Th12xY1
X-Gm-Message-State: AOJu0YwcoGIzcaKTiVssGYih3XgknMElVaUSI9Gze5LCDqWrw5sjP80V
	LORATDxtfeb0z2PC16itv2nC129r5xwex2X9kXvWiWZxl95RgmIFW15t11Aw8ZL1Be3yORAynz4
	qWT2vDT0oXqSNlHrM13NIW192fPUOO6DaKNehuA==
X-Google-Smtp-Source: AGHT+IEmSQRtsmi9qrBir2bfVjCB/SQEucaaV9YGbI3BoFMzakNXhdNYP6vrUbPSuXDlSiSULIWHOWNxXgTkE8klnbg=
X-Received: by 2002:a05:690c:60c6:b0:615:c96:1a8f with SMTP id
 00721157ae682-622affe1b3amr131034567b3.17.1715668207682; Mon, 13 May 2024
 23:30:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMSo37UN11V8UeDM4cyD+iXyRR1Us53a00e34wTy+zP6vx935A@mail.gmail.com>
 <20240508075658.7164-1-jtornosm@redhat.com> <CAMSo37XddAvE199QpA_WR5uwQUjzemF8GxqoWfETUNtFw6iCrg@mail.gmail.com>
In-Reply-To: <CAMSo37XddAvE199QpA_WR5uwQUjzemF8GxqoWfETUNtFw6iCrg@mail.gmail.com>
From: Yongqin Liu <yongqin.liu@linaro.org>
Date: Tue, 14 May 2024 08:29:56 +0200
Message-ID: <CAMSo37XWZ118=R9tFHZqw+wc7Sy_QNHHLdkQhaxjhCeuQQhDJw@mail.gmail.com>
Subject: Re: [PATCH v2] net: usb: ax88179_178a: avoid writing the mac address
 before first reading
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: amit.pundir@linaro.org, davem@davemloft.net, edumazet@google.com, 
	inventor500@vivaldi.net, jarkko.palviainen@gmail.com, jstultz@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, stable@vger.kernel.org, 
	sumit.semwal@linaro.org, vadim.fedorenko@linux.dev, vmartensson@google.com
Content-Type: text/plain; charset="UTF-8"

Hi, Jose

On Wed, 8 May 2024 at 12:41, Yongqin Liu <yongqin.liu@linaro.org> wrote:
>
> Hi, Jose
>
> On Wed, 8 May 2024 at 15:57, Jose Ignacio Tornos Martinez
> <jtornosm@redhat.com> wrote:
> >
> > Hello Yongqin,
> >
> > Sorry for the inconveniences.
> >
> > I don't have the db845c, could you provide information about the type of
> > device and protocol used?
>
> The db845c uses an RJ45 as the physical interface.
> It has the translation from PCIe0 to USB and USB to Gigabit Ethernet controller.
>
> For details, maybe you could check the hardware details from the documents here:
>     https://www.96boards.org/documentation/consumer/dragonboard/dragonboard845c/hardware-docs/
>
> > Related driver logs would be very helpful for this.
>
> Here is the log from the serial console side:
>     https://gist.github.com/liuyq/809247d8a12aa1d9e03058e8371a4d44
>
> Please let me know if I could try and provide more information for the
> investigation.

Just want to check, not sure if you have checked the serial log file,
or do you have other suggestions about what we should try next,

-- 
Best Regards,
Yongqin Liu
---------------------------------------------------------------
#mailing list
linaro-android@lists.linaro.org
http://lists.linaro.org/mailman/listinfo/linaro-android


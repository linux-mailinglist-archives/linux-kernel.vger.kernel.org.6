Return-Path: <linux-kernel+bounces-228389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 887C3915F2F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 08:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43D67280A79
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 06:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA0014659F;
	Tue, 25 Jun 2024 06:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NAXHIs+N"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D968114658A
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 06:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719298766; cv=none; b=AgCZ+0KxS03HpXQlr+eWQlPMSQ+orN4v8GMtNwJgth5ITVEIo9QwR6tWU1MHxzf5cMo2NN+SmErTRpBtPs2ngG/cF5J6tLRe9LyvxOGUTqRGmdKFS95fICWs9q+I7Qj41MWs0T5EOzm+rFIYjooFOAtYRJKrIP1alfk40r+kZWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719298766; c=relaxed/simple;
	bh=aDB98kbQuG4jMhc+5/YnSzAXedCDskwQrRRjdfeVksw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mmQO8YzHgW+rES9NmpiZFRO21C45AALbfQg0WahtHMGmxaKViwqs9Hf2TTB8zsuIrv4zk0xxP5kCLyDf5BL8THS8jcl+mx+C29lmECMLIeCrt/WhnVO4PD8FjYZFDYY954Fd74hEhwNqW5qjKzxe8IKOCdPKWoHxSA6E9PnzcGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NAXHIs+N; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-444fdaed647so20751cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 23:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719298764; x=1719903564; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aDB98kbQuG4jMhc+5/YnSzAXedCDskwQrRRjdfeVksw=;
        b=NAXHIs+N9y3WHT3Ctj4tI3OOaGIxg9dTxfSftusOHOxFWAlSCaCXb8P9iP3AH27cdS
         EYdH6XipLN4A3TJu7aVmIPA5hIahPSS8MR/Lps4SGmjki1mBTTq3gAUsc1eeG+tkk7mj
         bdP/ZlmOS0J1mMAUGtGHtnTVePJsExghI7Da9lh/0FMbAcjy1uKRRuE1aFD/+S36BVYX
         kFYX08MgR+idtlptnTceYXdCIad4xTXzT5ojEshTU0lcv1PBUYINphoBvUvWnYHMXlmi
         P5HrM+jI2roUG6DMQuxesyC1J3/Of2atkmnZtwewXE4xXGsypINIPWUwtkrvbRnU19qY
         6soQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719298764; x=1719903564;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aDB98kbQuG4jMhc+5/YnSzAXedCDskwQrRRjdfeVksw=;
        b=QZ5kSuE/mrIzE7Fms1RPvHuMzkulLRNoe8H1qj1rIAUlHl4BtbmtpWOKZTIJKAZah7
         cQ0AbNJvfXa+NjhQ0rKAz1BlhL2+7ss4Mxv62lkwyuFgY8JXSBGNE0CjVCck8DGwp8TL
         jtAlELSfpwUICwuk5Hqx6ufx1wzXqrYwbXF9VLv7EcN6hd8+1aN4gkJvXsq54TyYsE+j
         Zt7DzKbjN5yL3vr14qQQLEopTBCL+XRhZvwIwhY8tMoY+4f5TorhERqkj/GMzMdj0ejP
         6FAcQ0zuxHrXqzdibO8MoLRS9MCh08UMKt68MxHTDqovo58QJ52AyX5dGtADVWHZwukH
         vyuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWr/s+xAVj7aXJQyHW5pHoB4snOYzqAQDgCQk0YUL2eZTL4flok2wnlvqPnvAZidWS4+MJNMJll88FgFXoLxxMkgbHc3AZBDs4YW64w
X-Gm-Message-State: AOJu0Yzi6ZihZz3uwuEnH1XOPS/Ok+L13haSny7PSlt8LtuzYeSjh2Pp
	kAE5OXhNOuEiMzDHxG6N4mx5O5d7u25eioFOdJ/wFZZtxgUf+qny8bxwtbVCN3IKmUMX9MM6CNC
	atPdyZlBMC+6ZkrY/eAVPoQhyos29cVLVSigT
X-Google-Smtp-Source: AGHT+IGlJT0nqE32CrXN7HXAt7RK51Q1QHp5YX2obTfJeNPoOwE90ZsgUuMGJJ3b2P0/xpgtbmKWay4QfzyN+SXaZj4=
X-Received: by 2002:a05:622a:1483:b0:444:bd5c:eb20 with SMTP id
 d75a77b69052e-444f36d473emr1441851cf.19.1719298763626; Mon, 24 Jun 2024
 23:59:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611171600.1105124-1-aniketmaurya@google.com>
 <20240624052851.1030799-1-aniketmaurya@google.com> <20240624052851.1030799-2-aniketmaurya@google.com>
 <e3160411-59e0-4806-a00d-b99564384180@linaro.org>
In-Reply-To: <e3160411-59e0-4806-a00d-b99564384180@linaro.org>
From: "Aniket ." <aniketmaurya@google.com>
Date: Tue, 25 Jun 2024 12:29:12 +0530
Message-ID: <CAMmmMt0Qd9tS3TQ0nvC_x=yskBbpTwL4o9tD5+6F8Yi1ueiG5g@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: i3c: dw: Add apb clock binding
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Jeremy Kerr <jk@codeconstruct.com.au>, 
	Joel Stanley <joel@jms.id.au>, Billy Tsai <billy_tsai@aspeedtech.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Your email still suggests mismatch with name. Please confirm that above
> this is you full name or known identity which you want to consistently
> use across all contributions. In case of doubts: please consult
> colleagues in Google (or your legal department, dunno).

Hey, my full legal name is "Aniket". Please don't mind the text in the email-id.

Thanks,
Aniket.


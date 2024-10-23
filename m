Return-Path: <linux-kernel+bounces-378478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9C39AD124
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 18:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56B671F21A4A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 16:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35FC31CBE9A;
	Wed, 23 Oct 2024 16:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="uGCpb5ab"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84611CB536
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 16:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729701519; cv=none; b=L/TFitKi+SFU+x47W8/pK4GR+JCZwJUoyNgl3GM5tyns/hVFXzqYPtBO9p94YwwUP0qblIU98u2AFMUFcnhzK8Qokavwxh6tS0/35c0ChWjdpEv3/MSc9vFXKyV3Y8SvTZFoFhIm9XJyzJfpG8vDdulaN37e+rMAKpvov4js+Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729701519; c=relaxed/simple;
	bh=2KGO9/x+zR1sj8A0z8FXdfQsavpMZB5tjb8iXzv7MBc=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=giCDb6AtyeGMBVfe0jwDHL/R/Aa9Fhxpl0s0Jq6x4+AxzRa/XKlWdsw3/kCnEC5BqyIseEvTATwQpRuSsnlX5WSox1KNxTy2A0gAaUSIkeEdRJSg6TRibIMn4JiduG0bkj1KOENOPcHq1cH9hUbXoSnCSfi7D2GGvDNUT6eEWT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=uGCpb5ab; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B227F41219
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 16:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1729701509;
	bh=2KGO9/x+zR1sj8A0z8FXdfQsavpMZB5tjb8iXzv7MBc=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=uGCpb5absfmh85IqbmT/JDjoYaOy3iXil7ITsr9Otsx66wPabRbZxFQl6p1WrRHgJ
	 b+pUgSaCQ7FTvVhTn/iIAH1tWEgnIGCZxFIRrxigL87bnhfqohhA+RujsO3zy3Vm0i
	 EASop8057c5na5h/RO1Gugby1KmzpGm4vQB0SbVPzkma279itG1ZSQfykrXmPRydfM
	 IhFkjBR9Y+YAmpHqomA9HSajfXqFPBn10tscA64GyPGgvMPzwEez5WiOIIHPIYPhUs
	 R6Q38EEO7wwSArr/3bz8R7JNSzA9xmgCqjkCk0cxbjDFk+QveZxGQoYCqQi7XzrAGl
	 M5MP8jH4zDZmQ==
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-5eb7146ba9dso5422914eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 09:38:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729701506; x=1730306306;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2KGO9/x+zR1sj8A0z8FXdfQsavpMZB5tjb8iXzv7MBc=;
        b=otgO9Fh8xP3htkUxtAGZ/VPjQiXcmBg3SxnxShfvva2gPD9/E9SRMdBVZbiG0kGkga
         E251Dv5k5C7Ha/KOCMa9ZfhA4C7J1jt0ObvVUI/IFcRUQkl0RwlShdJgI7yaYMENh/VL
         DOLqBRyw0EuY5yu27/wOzMVvleUYQ4UhNmBTJgHjEGsJXfLStk6XHvH5eIiOJ0oTuFqg
         oZp9dfAqnFF1FNKlomAMAGG3YagNG9vowm7sgP/jksTHO72+sMN3tt8uRW4Vg13TAi8s
         xMq2R5N2Xt1QwI68ZcwL6hRWVcJZsqNrxnq6IJoOk/4obB7wlyG6rbL8IDXKrcpVoRAg
         jqTg==
X-Forwarded-Encrypted: i=1; AJvYcCVEeRGJmMBbuQvTSYG3ZeTNaf5OwSD94t4SVS10td3qfQdXo3uDTyj2WXWMtONJOcyL5k8BZZpykjbMBU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTbLBVdKYa/1I11tlzih44raaQG4p8AJGZXRJBF6bebtdOJXXh
	Fa0jLJ5XXhKI9TBHCwuVq2EYAW/hFo7x6+J4fbpB6ax+RhU6jaPfSuckG9MXBybW4S5n2LG8Y5E
	o2IC+KhHggIyw7cLT7iuJHkwZZb6AMfXOtDAy1g0/9gL3T09lgsDcnDoLZF7hoRVJ9P7E1VIxgt
	gYJav43xn1gw5nhn0OgBzsJT57bqXylcJ3QCksk6+DFZNsi6naAkHH
X-Received: by 2002:a05:6871:58a1:b0:287:c014:c979 with SMTP id 586e51a60fabf-28ccb404424mr3446449fac.13.1729701506394;
        Wed, 23 Oct 2024 09:38:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYKVer8iHAkiMMpVseZz+FbkbvOVCl9iXO7WeY67iQ2hOj/Lh97N9pnwdvNGMM13TWHpzNMqvtkjAlCvvT1/E=
X-Received: by 2002:a05:6871:58a1:b0:287:c014:c979 with SMTP id
 586e51a60fabf-28ccb404424mr3446372fac.13.1729701504622; Wed, 23 Oct 2024
 09:38:24 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 23 Oct 2024 12:38:24 -0400
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20241020134959.519462-3-guodong@riscstar.com>
References: <20241020134959.519462-1-guodong@riscstar.com> <20241020134959.519462-3-guodong@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Wed, 23 Oct 2024 12:38:23 -0400
Message-ID: <CAJM55Z9amwkWEK5GGKMiqh_6NQY=TBQhjEuFdMPBFd_hHM==4Q@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] dt-bindings: riscv: starfive: add deepcomputing,fml13v01
To: Guodong Xu <guodong@riscstar.com>, Conor Dooley <conor@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Emil Renner Berthing <kernel@esmil.dk>, rafal@milecki.pl, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Heiko Stuebner <heiko.stuebner@cherry.de>, Michael Zhu <michael.zhu@starfivetech.com>, 
	Drew Fustini <drew@beagleboard.org>, Alexandru Stan <ams@frame.work>, Daniel Schaefer <dhs@frame.work>, 
	Sandie Cao <sandie.cao@deepcomputing.io>, Yuning Liang <yuning.liang@deepcomputing.io>, 
	Huiming Qiu <huiming.qiu@deepcomputing.io>, Alex Elder <elder@riscstar.com>, linux@frame.work, 
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Guodong Xu wrote:
> From: Sandie Cao <sandie.cao@deepcomputing.io>
>
> Add "deepcomputing,fml13v01" as a StarFive SoC-based board.
>
> The DeepComputing FML13V01 board incorporates a StarFive JH7110 SoC, and
> it's designed for the Framework Laptop 13 Chassis, which has (Framework)
> SKU FRANHQ0001.
>
> Signed-off-by: Sandie Cao <sandie.cao@deepcomputing.io>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> [elder@riscstar.com: considerably shortened the description]
> Signed-off-by: Alex Elder <elder@riscstar.com>
> Signed-off-by: Guodong Xu <guodong@riscstar.com>

Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>


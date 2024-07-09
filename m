Return-Path: <linux-kernel+bounces-246690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D423392C539
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 23:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ABE51C21D86
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 21:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F8E18004E;
	Tue,  9 Jul 2024 21:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VR4eX/Gz"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1977CF18
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 21:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720560039; cv=none; b=pLSrDsPllUEKZ2iLm2obc50l9O+bVWRRPaF6eZyCNFIg3vfCfkSn4abHbvp8Y4T7r0qyg12v95Jj8+GCyrXAfV91mRYZQlHwRRcFHxSlugbkFJ3vL8WlqYggozX2WK+ccYTGv6TipoV3N/OwtBQnOXE57O9TokaGTmvEwXyIs0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720560039; c=relaxed/simple;
	bh=FFJHjDkxAlCKDz+WBu9UyKYDq30Ju2dNptd2o2tZcIg=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=mUffRzGu5E6zjxtxqQjaH6qkiZWh5u/e3Z/ReE0W/1I9NcYcLqN+Sle7qeSpUJfC1wLjXL0SsONVuxpW4m85ZB+Nk914V62bPHJw1ImRSyOcensmBLX3zTMgZtBVrJhQlhiZdZfIx6I+zDyL60bjQYeBxtRczfpkNAeUqHehgCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VR4eX/Gz; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-58c2e5e8649so280722a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 14:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720560036; x=1721164836; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5cSoILi4LYLW5hcJj52gP6uEHw5o1rTBz6BW8dlEU04=;
        b=VR4eX/GzZ5SRDXlee7b1J82aFXcdcLOcYVds7iQ7dGa8Cve+daToLJiXHpCPnt//dg
         2Xix8O0BsE5AvMuLucwDHHrS+G7HrXjugGv36tLelsPNqwUYUDxpxyaZ7UJJ4Dv8uFur
         vMPVg21rPkWBr6g0z4EQ4zLlKs8yFeQioTN5oaoxcVfXZrsr9XsAKHfidMfab/vmT/Oc
         bZ/OWXtXpoxyj9rAAeuXpNIJvfeWK46wMv46zclCwh3duHT1fpLJaG3er9kkA5WdfZ9d
         01bv1yrt/3N8ays7wunxfZmeDLrO3eLOg7Qw7izaspj1f4zImpV52rIVZi+mTEg9gKfv
         jf3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720560036; x=1721164836;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5cSoILi4LYLW5hcJj52gP6uEHw5o1rTBz6BW8dlEU04=;
        b=n+wKWIdbxi/rmbsTyTD/VmIgtjMrdT652kRAS8a0hCgXrSpBLosAzO2leN5TouVrOh
         SwCIKsLlv+iv6o1rriOMk+8FXwdRaKcHx4tk43cxDuKLaxY/OdHXWFWA5Z7XAj92phLa
         62FFDPUvV4de/2M5mNIz8BzjyNVy7s7AhFVDt+nZjMtmCXPsSMhuLajHyxe/jpvn123j
         TDrO0ldxpcmr5rjL1gVNI80fUfLYu/ioMdmIqCeA39U7eRewj2hps7IBK7cU8h5plLlk
         S8JOTEEvpNaksWQYI66cfS/nIDtzzpA2elwknCjJ79DRXkr+SnuCsu3iTP6VcuDugmUl
         ze1w==
X-Gm-Message-State: AOJu0YwFezUADL+l6wJtEQEexxONGDGY5gUDnRH5XzY4MbOKWFeE5dv0
	FU22uAcdQ1yJVqfztQNm8fU7xgtIewT/d5Iz4dVYvmyPpsyOvYsS7L/HeB59
X-Google-Smtp-Source: AGHT+IEN37GaV6iIQ8fvfpRq2HXpxV2uCk/GgG/mSjsYNDZbPACogtVf7hCv2HaMyp54iaeKnCDAfA==
X-Received: by 2002:a17:906:1d58:b0:a77:b349:ffd8 with SMTP id a640c23a62f3a-a780d3edb7amr250328166b.32.1720560035674;
        Tue, 09 Jul 2024 14:20:35 -0700 (PDT)
Received: from [192.168.178.20] (dh207-40-28.xnet.hr. [88.207.40.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bba548e8sm1483886a12.1.2024.07.09.14.20.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 14:20:35 -0700 (PDT)
Message-ID: <d1145d32-4b77-479d-bc66-0bb8694a6923@gmail.com>
Date: Tue, 9 Jul 2024 23:20:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Peter Rosin <peda@axentia.se>
From: Mirsad Todorovac <mtodorovac69@gmail.com>
Subject: =?UTF-8?Q?=5BPROBLEM_linux-next=5D_drivers/mux/adg792a=2Ec=3A134=3A?=
 =?UTF-8?B?MzQ6IGVycm9yOiDigJhhZGc3OTJhX29mX21hdGNo4oCZIGRlZmluZWQgYnV0IG5v?=
 =?UTF-8?Q?t_used_=5B-Werror=3Dunused-const-variable=3D=5D?=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Dear all,

On the linux-next vanilla next-20240709 tree, I have attempted the seed KCONFIG_SEED=0xEE7AB52F
which was known from before to trigger various errors in compile and build process.

Though this might seem as contributing to channel noise, Linux refuses to build this config,
treating warnings as errors, using this build line:

$ time nice make W=1 -k -j 36 |& tee ../err-next-20230709-01a.log; date

As I know that the Chief Penguin doesn't like warnings, but I am also aware that there are plenty
left, there seems to be more tedious work ahead to make the compilers happy.

The compiler output is:

drivers/mux/adg792a.c:134:34: error: ‘adg792a_of_match’ defined but not used [-Werror=unused-const-variable=]
  134 | static const struct of_device_id adg792a_of_match[] = {
      |                                  ^~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

The offending lines are:

drivers/mux/adg792a.c:134
134 static const struct of_device_id adg792a_of_match[] = {
135         { .compatible = "adi,adg792a", },
136         { .compatible = "adi,adg792g", },
137         { }
138 };
139 MODULE_DEVICE_TABLE(of, adg792a_of_match);

Hope this helps.

Best regards,
Mirsad Todorovac


Return-Path: <linux-kernel+bounces-413917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B212F9D208F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 08:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B2CB1F225CB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 07:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13301514DC;
	Tue, 19 Nov 2024 07:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="BYN4gdSj"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C617C35280
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 07:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731999951; cv=none; b=MZopUWIxlELC95WAJ+JEc1uTDUXZB4qSoT67SsPXk7JvfSPDq+FKdUKW0V7g8VOIGfCZtF3HFOs0r/8K0PJjtyqsJyehJYTaS5Jnntd483+aSi1vT+f84pVqst4ZEvyifXYaioMB2R+xhFVCEoSD4AAkW61gBkh0lf6WjCTAjkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731999951; c=relaxed/simple;
	bh=iDb28fTOm8ISllSH8ERAKbns7Vi17u61TzjfPWH8Qjc=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=aQCZd5s7+/HNwUuEIFCAodEyXBeWo1pCYpMIRUOwj5OQ3PPSNH7XfvENNkQw2tFQiGdUtXdab/JJn48jLXNrFNyKGKtH/HmOyCnFhlzNQ/Kh3Dxh7h+8/d4A7LW/M8DfEmy4UK3ZJ8tvXCciO423vQIEg7C/VPFVq0ztNd/p8xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=monstr.eu; spf=none smtp.mailfrom=monstr.eu; dkim=pass (2048-bit key) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b=BYN4gdSj; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=monstr.eu
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9ec267b879so651390066b.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 23:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1731999945; x=1732604745; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0fZbcFDklvhw6+95htQNXSkNSG0FZlZGX3fcKVcp/lc=;
        b=BYN4gdSjMwp594eaBiWuWXJjml7Diw3WcLFPPpmU231g1N5oqNOCZ1mv8Pi3rYK1qP
         HHJnevFud7emDmpHIjtW85vm2G05lHwm2SBIZ1HS7JHmVAnKb4i69620pMvdxNm9Y7Wf
         D6sNqyNEVX0o9pCeQVpvkkc4j6LKszqYjGpFBW6a+FqX1waQUYBULtEqxkebWvzURPHS
         stzHyG0Xs8pbQ7cVZZIHQO2RDzo74Jfh+mJlRctZm/NpnHJ+LaNzDP5f/qhgh8ldwXZG
         gU03pzaBrLj8YDOBwwEx9+TzbYcPGZPO2tK0LhifpcaRRYAfaiWkbAw7//EW1sASFW6P
         vlZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731999945; x=1732604745;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0fZbcFDklvhw6+95htQNXSkNSG0FZlZGX3fcKVcp/lc=;
        b=DQ6b/tz1hVtGboklcIQQDW0KqposBTZwHFogsW4Ze4YiifUQoMuaDNrRyFf7fvsSNV
         9qE5lT5vNkCrVgdSDht27GN1yeoC7MQbaSmI4mbnKnaBn2EsI3LP05WJ4Qq4XjWzdW7A
         w+pczS277yggtbT1y/orDjeZil1rk4FcaTKl3KqsjlF07TaXV2t1oh9eZY5Obag6qrnp
         +yBEzCpDFO5x033X/5j6NfrRmvj32eLUzS9Ptfg4sQOAjfsgi26LyqvOvR+WJFy4DEuh
         O518ER5yDiqQN4P/lkMzl/btZ3xr+xdb8eNT9wHPqpTe+zmi8So5Uu66NlSbuN7VdLZg
         yf4Q==
X-Gm-Message-State: AOJu0YzvHboTo2edNtHckjE559UxgzsuwiTSQlfG8aWir4VBm24e4GXr
	JAMj7fqbFIQQmZVU1NzDYyT2egSb2vcmAZXbGyuhX9iDVSwDm4+tEYzkSpEFMQ==
X-Google-Smtp-Source: AGHT+IGkH8XhBZ1/AHVG0ycNZ8XrGi9Q1UGQ98Wzy7AJ/xKLDKFi40rimg9r8npeHCDkudyrhR3bew==
X-Received: by 2002:a17:907:701:b0:aa1:e04f:e352 with SMTP id a640c23a62f3a-aa48341361fmr1504807666b.16.1731999944533;
        Mon, 18 Nov 2024 23:05:44 -0800 (PST)
Received: from [192.168.0.105] (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20dffd7cbsm614589066b.117.2024.11.18.23.05.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 23:05:44 -0800 (PST)
Message-ID: <39293bc3-ad14-4196-8a25-a13d66982b2f@monstr.eu>
Date: Tue, 19 Nov 2024 08:05:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Michal Simek <monstr@monstr.eu>
Subject: [GIT PULL] arch/microblaze patches for 6.13-rc1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

please pull these 3 simple patches to your tree.

Thanks,
Michal


The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

   Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

   git://git.monstr.eu/linux-2.6-microblaze.git tags/microblaze-v6.13

for you to fetch changes up to eb01f8f3c446ed81e3b2c44b7fbed8a5d6be9d3d:

   microblaze: mb: Use str_yes_no() helper in show_cpuinfo() (2024-11-15 
10:27:48 +0100)

----------------------------------------------------------------
Microblaze patches for 6.13-rc1

- Export xmb_manager functions
- Remove empty #ifndef __ASSEMBLY__ statement
- Use str_yes_no() helper in show_cpuinfo()

----------------------------------------------------------------
Michal Simek (1):
       microblaze: Export xmb_manager functions

Thomas Huth (1):
       microblaze: Remove empty #ifndef __ASSEMBLY__ statement

Thorsten Blum (1):
       microblaze: mb: Use str_yes_no() helper in show_cpuinfo()

  arch/microblaze/include/uapi/asm/setup.h  |  3 ---
  arch/microblaze/kernel/cpu/mb.c           | 10 +++++-----
  arch/microblaze/kernel/microblaze_ksyms.c | 10 ++++++++++
  3 files changed, 15 insertions(+), 8 deletions(-)


-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs



Return-Path: <linux-kernel+bounces-169807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2518BCDE0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 14:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 880C52882A2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 12:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BD6145B21;
	Mon,  6 May 2024 12:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1kHQ/uG"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9E7145340
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 12:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714998275; cv=none; b=uOp6zeO8yZNlEEoKDqjckuIZnD5qZ/3b3S6K/DQk8dlDMSUuu2P/3VdsADDx/SURlpTAdBFDDhVpuBeVmZMSs2WL6rFc+AQ8U+LM2X8IYEfYYV5P7AJ7b6iw/motAIPMsrXhmSvZwHcwop4IqyGY52yMxWC1biSXrXoYJK7JeBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714998275; c=relaxed/simple;
	bh=VCwefnSO1mWP3wvCYO8NG8cmLf3dw5blRuYik9s4/vo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=TFBlr8exwDGFL+sPbkHAwC/xa16IWES7+DDs7rSKZ1iund9Gp0Mfvupwldd5MPtn53LOpYkLYEueVMeNyGY7TyG1DmYwtRj387shDKVNlzg5DoJ8ihtkLLWJl5vRMHiNj6kHFgfvt5NeSmga10X+eCHD+EI5+x6C1/CFZL1+vUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h1kHQ/uG; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6f489e64eb3so121530b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 05:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714998273; x=1715603073; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VCwefnSO1mWP3wvCYO8NG8cmLf3dw5blRuYik9s4/vo=;
        b=h1kHQ/uGP1VkxHlT/S+woM57wj7CoNLP3ULLeK4wKr2yuAreZoI2PHuuHO/8TGE1Sb
         nNrDdqrWcKemstiBh4sAxYRCDTHjLnzvJvc8RlEEnVfSG7c36BL7iVKBS+PjCkfq1eR9
         w9/okZE50rj6IWMyRx5AsYCbE5+nUfxN2SHrx77u18/kahVDsQDiNamvv4XnOxfaWwvS
         DUr1lrughX4d7ZiO1vQVp/nmB7WzIXy0NYomkduBUIFyJl6pDMz0Gf9xl2ltlOfI1qRs
         SjLpXbhJ8DbjAfzDK+gzwWFwqHrkf52Ap9FcF7Iat+7zwOIXK5Hi5nwaL7LGcRNSygqG
         xlqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714998273; x=1715603073;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VCwefnSO1mWP3wvCYO8NG8cmLf3dw5blRuYik9s4/vo=;
        b=BQb6YFVdlAO3M3tLCq++3XTnOFJM1r1hUgjJIUbxpbd9tjnNGYN/QeRTXh6pNjSZ9C
         LMB7TVFBqs3wzjbK9rTWLvJuDolajVxtY0TMNhh95VuH4EoJtkpmk11izsSudsXkD6xb
         SZtDRFmKfor5GYdmSsbCw4Fphs2dwAqfeUaS9sKkkElgf/5Edmes0RfHX6haOlc75+nc
         k/mH+1b/t5OqMCp6TFH+ewjmBMnrHHBB9NQGG5rkSiri2ric6STP6nAmqgYupvCkM4c4
         6x7zjBgJ1ATQTfNg46qfi5wyIl4B2Ttuvizv9A13Gz4NVnQxURxeffu8iuYQ7hEENKpM
         aJ1A==
X-Gm-Message-State: AOJu0YyFUigC2bWPe5KRM+14ijxvizqhI+IIvyjO5Z+HKTX8+jeJ+JmX
	YUbmT8zuS3O3ygXCKSiK+yH+scuR1dq9ZTajI1JBlNwgY8vpi+kROVrII8xaxVQL6Yqg5792mG1
	yKyPKboFXXcVKwG/rWR6fLeQbXCdk99JLjGLPdw==
X-Google-Smtp-Source: AGHT+IEd/lQadz6HLodst0XvIwwJpRK21g8fJQpVh96YyjFG/ZaiqKRyYGWz1PmiCH/1XNfAfQk+VMJoNuOkf0SQSxw=
X-Received: by 2002:a05:6a20:9c8d:b0:1af:8ca1:8fec with SMTP id
 mj13-20020a056a209c8d00b001af8ca18fecmr6721824pzb.16.1714998272828; Mon, 06
 May 2024 05:24:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Gia <giacomo.gio@gmail.com>
Date: Mon, 6 May 2024 14:24:21 +0200
Message-ID: <CAHe5sWavQcUTg2zTYaryRsMywSBgBgETG=R1jRexg4qDqwCfdw@mail.gmail.com>
Subject: Re: [REGRESSION] Thunderbolt Host Reset Change Causes eGPU
 Disconnection from 6.8.7=>6.8.8
To: kernel@micha.zone
Cc: linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello, from 6.8.7=>6.8.8 I run into a similar problem with my Caldigit
TS3 Plus Thunderbolt 3 dock.

After the update I see this message on boot "xHCI host controller not
responding, assume dead" and the dock is not working anymore. Kernel
6.8.7 works great.


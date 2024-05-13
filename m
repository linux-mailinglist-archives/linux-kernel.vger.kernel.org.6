Return-Path: <linux-kernel+bounces-177264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ACF38C3C1E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 09:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D99B72814C1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 07:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A35A146A99;
	Mon, 13 May 2024 07:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lV7zMhR3"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107BD146A8E
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 07:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715585611; cv=none; b=hioqWsyp4uFn43CqkCeEmZWScpatcRXzgTVNsgXVlDO+3o/zJtQLoWMUCN8uf6udWkOp2sB+BlgDwD30mOs7n+tgsnmjptByYoowTepYqHYrm84gthBuAs5Rpj8ClJIp/feGqHEjQ+jzUyk7PYLOBfCKfAF1jnCC4MI9PFdrZ6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715585611; c=relaxed/simple;
	bh=Od9QiWvWmZMZiMU81TUDIxPyRXlwB39rotn9OAf3Uj4=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=M+Ay0LfXjxCqq8KsQ6bgpJyDsH/+YcnCQwqWdQDlDf/v+sAOK/gxf9/H/3Woip7zQnmWgipqxhtCryVliA5lmcnsC6Oho03Tm63k40soWZ64Zep2VAloyaodwko2AbuH2rHTHtYghEWCnq4jvf/ZDYEGDbreSS0BIWTWQa71gEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lV7zMhR3; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a59c5c9c6aeso975740166b.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 00:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715585608; x=1716190408; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1FjB0AqB0xUJdRaA1Y/pkrd5humBzFSEH7+VKWGyYFg=;
        b=lV7zMhR3OExuGA6RhP7BTlSwg0UuNsUsdQyAUrDY6ZOp0HLhBT5H/zKOQ0QYqoCI9r
         PCTBn6hFG+cctSTLGRjF5S0EiqntHOC6xHusDC4XavU5fNMArmo1PdGKofkBv07FgEOs
         NoF7Fgaa8937MzPHaAXkP+s6c6Nk046ugn8mEAyjROBN9aLetX04qNVaUzkGq7NMQKAn
         ixX4x5eUi2Mqt29plt16wIRp9bxewVAMQ7qSLIf+saxpHd/Ph/10J660dHflbFXwM5we
         TXP7mTU25ma138uLnFI/3iLVsjQFGS8AOPP8toWPKxlcA3xwnR258049NRYhYrgeTg7C
         DQPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715585608; x=1716190408;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1FjB0AqB0xUJdRaA1Y/pkrd5humBzFSEH7+VKWGyYFg=;
        b=dojvdr0rVlgKThZ4tu055ld8n80igNoUBUwVyvMsisc4ECYJPl+xrFXHBv5/xncKfK
         S6z6L0UTYcmTPcx55uBIccSvQNARPKaH4Jw/pma84W47z4WIwz2dNdG3iLVb262djcf1
         WBPI+Pi2BlBypUqC2Jw0Ed6ohWSeX9gwAO2a5p005UQ7zLkwdwu2qotIxdI8YyacTM+Z
         mQNsNENzoRTfysmN5C6oQ9ZVxs4hNZ8Xv49zgwShNTyGyxTMge8/pIBngAR8Oi7QBhA0
         tR0aWYh0Gg7ZDs9u7jj9i/HG325Frbbbxyr7HJzXd5YI/LwR0DFA6Bxq5qdp7bdNgSVT
         ZQDg==
X-Forwarded-Encrypted: i=1; AJvYcCX4xuaI5kUJEv7MePvKziv3V5SUFrpoKegYBYjSNQ87MjXceT63bGgItbPN+ioahCnYZtLfX/mCtaHrW2bRnH8DlGvMkmy8MRZkgX+8
X-Gm-Message-State: AOJu0YynFHqVhxxyiWXDy2GpnFCVfW3cSfRLJHV+dCc2XdRgVTLnWFBu
	znHr3Knr0ZHCDddEpRxcYxNLMjWypFLtb6PBxwQCftb8qaBg/5+G
X-Google-Smtp-Source: AGHT+IHfShkpwIQtxfMZfMFtl72ZkhgBpxD+MXVqbPfZBd3R/y17q4h10iZi/Dp0FW+Dbmab51haGQ==
X-Received: by 2002:a50:9fc9:0:b0:56e:24a5:587a with SMTP id 4fb4d7f45d1cf-5734d5bec0fmr7275204a12.11.1715585608180;
        Mon, 13 May 2024 00:33:28 -0700 (PDT)
Received: from ?IPV6:2a01:aec0:a3fd:7260:9636:62ff:a8fd:5751? ([2a01:aec0:a3fd:7260:9636:62ff:a8fd:5751])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733bea65b5sm5844039a12.6.2024.05.13.00.33.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 00:33:27 -0700 (PDT)
Message-ID: <26d4ad30-c0fe-4286-9802-aa6afbd8074a@gmail.com>
Date: Mon, 13 May 2024 09:33:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: hch@lst.de
Cc: kbusch@kernel.org, kbusch@meta.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, ming.lei@redhat.com, tglx@linutronix.de
References: <20240510151047.GA10486@lst.de>
Subject: Re: [PATCH 2/2] nvme-pci: allow unmanaged interrupts
Content-Language: en-US
From: Benjamin Meier <benjamin.meier70@gmail.com>
In-Reply-To: <20240510151047.GA10486@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

 > From: Christoph Hellwig <hch@lst.de>
 >
 > So let them argue why.  I'd rather have a really, really, really
 > good argument for this crap, and I'd like to hear it from the horses
 > mouth.

I reached out to Keith to explore the possibility of manually defining
which cores handle NVMe interrupts.

The application which we develop and maintain (in the company I work)
has very high requirements regarding latency. We have some isolated cores
and we run our application on those.

Our system is using kernel 5.4 which unfortunately does not support
"isolcpus=managed_irq". Actually, we did not even know about that
option, because we are focussed on kernel 5.4. It solves part
of our problem, but being able to specify where exactly interrupts
are running is still superior in our opinion.

E.g. assume the number of house-keeping cores is small, because we
want to have full control over the system. In our case we have threads
of different priorities where some get an exclusive core. Some other threads
share a core (or a group of cores) with other threads. Now we are still
happy to assign some interrupts to some of the cores which we consider as
"medium-priority". Due to the small number of non-isolated cores, it can
be tricky to assign all interrupts to those without a performance-penalty.

Given these requirements, manually specifying interrupt/core assignments
would offer greater flexibility and control over system performance.
Moreover, the proposed code changes appear minimal and have no
impact on existing functionalities.



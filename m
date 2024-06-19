Return-Path: <linux-kernel+bounces-221804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56CCC90F8D8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 00:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 018721F21717
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 22:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA1C15AD93;
	Wed, 19 Jun 2024 22:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TUlzPOk4"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C647F476
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 22:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718835056; cv=none; b=mkFLIvTf3woaBN+S3DJlhWK36AZ5NdojeG1M1/oKTxsHEphjrkln6sZUMUnHgqDz2vNOa2HkGTXOZPvV4cX6bLg6VyEAS+2n3pgzpEJOq81rV6hhOEu/rXkk7LZxM35v0GTKQGy30Ej8oPCzRvSi6LLoKZ5/g1biVLWN6FGgljY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718835056; c=relaxed/simple;
	bh=/8duXVmUwY78tqC2oHwML1diQjLonOWr0Eu83ghH19U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aX/0w/E4CA8TD93SHvuxrPebd1899NOxjF7BbMXQkrruzHOL92qx6sbHWNUTYbpItLmPLUbwDUo5lJpfi12mB3npAfDvBs/MF4rO+UeMVzaDRCPuqx/IhOD4/LpfzHwXgguqH76Damz14AhmmRrOr91ZFjP1VCc0yTTz24EvCQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TUlzPOk4; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52bc29c79fdso224244e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 15:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718835053; x=1719439853; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bAIy7NXQ9HJqRfrqfLw5oJNnDiX02UKX+K0DASgrWxo=;
        b=TUlzPOk4hedJJqvXnHNvOLvDqKYrXSNCSrUevcswQqubn6HL1CErl7XuSoMSxvh4in
         59Ptv72UK0iEdkqsylL4GvlmTe6RWQuWzI4TFSiY+fwXXUZ9D+Y5zNG+yL4ymtKEBvws
         q8LEkGDs9mJatYCDOMFLIaR/8CRRkV9MvzgMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718835053; x=1719439853;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bAIy7NXQ9HJqRfrqfLw5oJNnDiX02UKX+K0DASgrWxo=;
        b=gqbAGUE29sqZKBZnLMo365RvqhBiIg0n2r2KK5GB6tLX/4kWqyJQfsGYfa5fCgfHRN
         e9EvY8EIQGc5Xch+BfsW3EiK0hN/xiACMQomOBm7fsauzxYgGDxTFyNvL3a/9VbvrBig
         7xd6tsbkhgYD4LOfhmS2WAccLH8yRP3glKGftculZFEoB3dcNV8LTOmEOO2ariN4wtSM
         KUvBoMjCljnrKATcYxkyv/4XGgnwXZcvdy2O6TycF51DUiSLAREIhWyuPqvYgkL+kzSL
         fsux8FTS6MUKvcqUZt9qIMimIsdrmxOKcBSrHAWqcMg18kpUqkx3dgnxuEwh/OUe13Mw
         s4+g==
X-Forwarded-Encrypted: i=1; AJvYcCUunPORHEKGZqzcdUVa/dWWnHNX4s38WF2+iNxXPxPP+h8gSdiomxnnbu/HNd0KtrUGesWQc6k0JFuuzSDy3Zw6wEGHFZTDsT2PrYCC
X-Gm-Message-State: AOJu0YybqV9DTNyrb2ftZPceuT1VSEH4Qv3XjFWc1ebLXAH3Nzi7hyVG
	NrCSLuW1mX+EFcrhBsUlQo/JpleuwcwJ2/v96k4Us3vUuvrgoSAnOAkfd72mI1ZwrbvUMDeR33i
	Xy1AK3Q==
X-Google-Smtp-Source: AGHT+IFFywu/iOaO+CjZTwXbK0oQm9RLSZEUYSPFry0Ic/E1Og8tZUbTmtAdesXGHtknJn8PWaAipw==
X-Received: by 2002:ac2:51ab:0:b0:52c:8304:db31 with SMTP id 2adb3069b0e04-52ccaa32fc8mr2471243e87.27.1718835052856;
        Wed, 19 Jun 2024 15:10:52 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca287aeebsm1848492e87.234.2024.06.19.15.10.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 15:10:52 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2eaae2a6dc1so4554541fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 15:10:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWqc39SAKh/vvymW2uJRn5dvclEckK4lIiBY2te6eZ764b+0bxo3XLBvLE8Z+2rHy9NiXecySnSJYI+TkbNm+snSJ7Y0J34QgApgjwA
X-Received: by 2002:a19:8c14:0:b0:52b:fac5:a3e9 with SMTP id
 2adb3069b0e04-52ccaa2abb9mr2687575e87.9.1718835032031; Wed, 19 Jun 2024
 15:10:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wg8APE61e5Ddq5mwH55Eh0ZLDV4Tr+c6_gFS7g2AxnuHQ@mail.gmail.com>
 <87ed8sps71.ffs@tglx>
In-Reply-To: <87ed8sps71.ffs@tglx>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 19 Jun 2024 15:10:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg3RDXp2sY9EXA0JD26kdNHHBP4suXyeqJhnL_3yjG2gg@mail.gmail.com>
Message-ID: <CAHk-=wg3RDXp2sY9EXA0JD26kdNHHBP4suXyeqJhnL_3yjG2gg@mail.gmail.com>
Subject: Re: [PATCHSET v6] sched: Implement BPF extensible scheduler class
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Tejun Heo <tj@kernel.org>, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, bristot@redhat.com, 
	vschneid@redhat.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@kernel.org, joshdon@google.com, brho@google.com, pjt@google.com, 
	derkling@google.com, haoluo@google.com, dvernet@meta.com, 
	dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com, 
	changwoo@igalia.com, himadrics@inria.fr, memxor@gmail.com, 
	andrea.righi@canonical.com, joel@joelfernandes.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Jun 2024 at 13:56, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> So instead of "solving" this brute force and thereby proliferating the
> non-constructive situation, can you please hold off with that plan to
> merge it as is and give us three month to get this onto a collaborative
> and constructive track?

The thing is, I have seen absolutely _nothing_ in the last 9 months or so.

So to me, "three more months" sounds like just delay.

            Linus


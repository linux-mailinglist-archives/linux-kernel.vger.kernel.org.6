Return-Path: <linux-kernel+bounces-348704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6BF98EAC1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 09:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC3C3280E4B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 07:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0608126C12;
	Thu,  3 Oct 2024 07:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQfRXL1L"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BFB3FB8B
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 07:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727941721; cv=none; b=d4rpnyx60M0nZp1JAbOWK38ZCoahOmvMKkII8UXJMXJU55EfQljbR7/3L2GYXg4Xh4ik2LxuABRyyGYHyd6NyjNoTKoBB6zzvhD/EY7Rtmb/YPyPEDCwx4k1mW6c73lhzlEJOsEKbw1B4jU0OjTW82VDfipknJa9GkaptaWIaxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727941721; c=relaxed/simple;
	bh=WLE7bJHPzXIMtqMmlAvWv3rrr3S9U+bRozdkJEMLtvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XMKalPVQ6A2XR/Tq7dtGPibeI2Z2cklZM9R8Y0ab7aTcSHSrLX9V2qxEczzLQZ5lw5ez3axneOLyFmNPa1hR8GcYNj/Jxc2KQDNRq0y03X3qmQxttHALwud9pJ0W8ldovMily4DYoVt5LpALZEaSehJqz6wsVJ8ngGPhQMJboqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DQfRXL1L; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c5bca6603aso733720a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 00:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727941718; x=1728546518; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WLE7bJHPzXIMtqMmlAvWv3rrr3S9U+bRozdkJEMLtvA=;
        b=DQfRXL1LdinOsAnUFpk0NjbDFkoOtcJZ7/ue6STDEegAViDHvHOcHJm73L0wYw5mfV
         z1bevLTysHnN1GerE8wuSS2RihYivYyjuV7bslSX55FzB+xe97NLw00QMWYqVBSS+51Q
         9pbztOMvvIbJH1s6Wtw5dnTi2Boy1P+6ifJo5SzoXIAE9/ub0pYRabSTJsaGzkL6EVIC
         5mG3Oak/fvUgLBnrHiEZ/WYjLhKcExYHrpqV+Bg/0PahCxcg4Igjb+hWVrRimH7M5Ajz
         UDaoXDbODbWzIMkeURnv+Etwb7s/DvdlIC3HWzx1gohl/V1h4ADOwn1WXMJw4n7QYOeb
         /DYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727941718; x=1728546518;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WLE7bJHPzXIMtqMmlAvWv3rrr3S9U+bRozdkJEMLtvA=;
        b=q1chccQKjlfQmZFZY7UaMhcKGxoUj0OdHRh0g6zHYHlOb2jDnceBaekcGWr3q088Ek
         IbKE8xOgRvPMOH8aSbnO4rSWmWpuXXUsby2ya0rSIiFQoSy72zg8gzTelLInYVKUPI9m
         H0EnrNj5kQfHgymSfThEzdt9ZRCns3Bh1CcESP4EAhjfidLX/JHG8M/I/s2ZKl5REZe6
         ZhOraFEyTLTn/EyelasFLdKCYJU7BQybY9E871JZdDaAmbwDdaE2Fn6vrYK24xBnBEWC
         EuN0/bY6p3Xm/OWAdk2M7yJ2b79yT155d1uu9SJMQ9FzIPDIRcZ+ncDB1PFcPNF2o9GW
         THpA==
X-Forwarded-Encrypted: i=1; AJvYcCWNMP3078rJIELU6AhfMpOBNfIgGmU9byLHWDDhGUPRWHOA7WWkPzb8s7F0JYcchLT8g/3oxVSBakO3gWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNh2wDEUMoKluUnd/rJ52HD6aOZbxDnJP2OZEmGw8fK7k8N5Lr
	PDd6rON75xiY1La4yomyG727YzQDER6owu+C8q9AThQ4rOKqYrMv+acYMNDCuRmvaf+BiQRuYFu
	+2vXKtbE4fYZ98/s62F/ksBpi2uI=
X-Google-Smtp-Source: AGHT+IEzkmm4t8mJgC1p/gY0iNLQmE4d1P0EHXwAD97P0FTo8HmMW9k1eQsCYzN1ESKgJfdqkvBo9p7U3LvVgIgqaeY=
X-Received: by 2002:a05:6402:2693:b0:5c8:821b:b7a9 with SMTP id
 4fb4d7f45d1cf-5c8b18e40a1mr3637289a12.6.1727941717399; Thu, 03 Oct 2024
 00:48:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <66f7b3a0.050a0220.46d20.0038.GAE@google.com> <66fa4a57.050a0220.aab67.0027.GAE@google.com>
 <CAHQche8jUaarbLbMcQ10NXQrqAZSz6ibghML38c2fkXALpEoug@mail.gmail.com>
In-Reply-To: <CAHQche8jUaarbLbMcQ10NXQrqAZSz6ibghML38c2fkXALpEoug@mail.gmail.com>
From: Shu Han <ebpqwerty472123@gmail.com>
Date: Thu, 3 Oct 2024 15:48:24 +0800
Message-ID: <CAHQche_Eu5kouirMW3zpakhjj=dbRJBeJrb94gsoYzcLFb1UAA@mail.gmail.com>
Subject: Re: [syzbot] [mm?] possible deadlock in shmem_file_write_iter
To: syzbot <syzbot+288aa6838b3263f52e7e@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, hughd@google.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, paul@paul-moore.com, stephen.smalley.work@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Have a try to mark this as a dup(if i can do so).

#syz dup: possible deadlock in process_measurement (4)


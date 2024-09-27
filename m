Return-Path: <linux-kernel+bounces-341419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D646F987FDA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 09:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 916F62856BF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 07:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E226188CB2;
	Fri, 27 Sep 2024 07:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0ti8yIWO"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6741D16EBE6
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 07:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727423898; cv=none; b=RypnmQiDsXrUqr+To1NW/12xPNgFeHWJfiTiZfRNucNtVYL1dkR6hesWv/lXJrqnFZu7FiDMVdy7M1kptocjEW6LZSIdC48eyjjDdOgo+UBgB1J7sK3jgqjyIp1pqHaJEGZShXtQR3iz0fpuVkHDA6d2Il0Rahv/CdGB44K80hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727423898; c=relaxed/simple;
	bh=p83mc5cTFsZ+q+a0hS5/bemDYdo42khH6l8dqrD9tj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HCTTn3ae4y7tIRnZiQKbAa/0+sbsRBdjrjgOKF3KKyF7Th+kUv0sTdKsA9RNC3wARXT/ysFqX35116SB0+s9l3BtNauVdxKrhXVFkLkHN0bifVd1lv9E4+9oPLxoOdU9sqH0VqeHdiU1HsbQ8/rWRVL5ATgIolBMuZCf+fJoUXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0ti8yIWO; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c26a52cf82so904449a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 00:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727423895; x=1728028695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p83mc5cTFsZ+q+a0hS5/bemDYdo42khH6l8dqrD9tj0=;
        b=0ti8yIWOS6GgQ0n4408nkyB6Uw9Z92MgniadKep3VuwyG5siILrj9xOjf3yIC1QNfH
         D5FOrqrJZSjEQyNn1Xp0loq0yi/LdSKgun2N2YOhpBAtaCYJjyN25Dimv4K1bsK/CX2k
         HRMt95hkR1yzrbi2WEbIdfwRz+k+BcIK5peQfPxK9LkLIW0S5MccreDuYpATz0CDKsRP
         qZll74FIzve6GEQT8rmRpDNrjJebg8Bb6u8nHAvbTuanvj1QP+uFAVivAWjMD/ZQIEeW
         L7dmMjEMLCQ8q/LZOeoiZlqaLLsaYAS/ieFJOG9dlXSS/GU7zC0g6KGjGDFyfkjENIim
         Xfwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727423895; x=1728028695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p83mc5cTFsZ+q+a0hS5/bemDYdo42khH6l8dqrD9tj0=;
        b=w+dInpL8P3QpwDDL9bIMSVMPpcpcASnBGHxy5cU9el+LlOmprN2UAhABj4WASxF5Nl
         En0V6UZh5XC2Fytc4+O59kx2WcKn0cGJUGg2sqzkQt5duc/VfcuPyFGHDti+VlWig8Wk
         2E5Cwz+iM+rVJ+5qqcer9TZ1eQJWoYAO8/RDynJmI3wyEw1opIL3t78Oic0rMg4Uy8Mt
         X9aJU9nn3/BvZHrSpeTITo49wdDS2XY7SWkrCL0a06rHWUFLWFxv0J30i+5IJw2akZGm
         0ZaR69sgkJBlVfOUO0b1Jwl1HMRUtjKcqTtff7MCSJ4g8HV7+HGvUuEN8LBpfSjIf3V1
         AP4A==
X-Gm-Message-State: AOJu0Yx1Cnp3oVHe5RXfmwfgQ6BT9t4iqh+ImoJNmbBUG/QaepvHU1Yg
	9i+SrM97cMxz/28EANm5t4viIq+I+YyiyO5jTCBPcWUERBeyAoRzIdUZf2rXzVKreBvWG2pPx4F
	gE9P8x6YLkZt8R64pyZl+9yQg3gIe7ZOOXHVK
X-Google-Smtp-Source: AGHT+IEGP+qp4LRFcjclRDU1NhKn69gauAC7ozq1LUFpYK+z2ADXKEBKeWhgJout6/e1B6W1kDDwaiKplLVEHoMJMSU=
X-Received: by 2002:a05:6402:3490:b0:5c8:83b3:a389 with SMTP id
 4fb4d7f45d1cf-5c883b3a50fmr1246402a12.15.1727423894272; Fri, 27 Sep 2024
 00:58:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926224910.11106-1-frederic@kernel.org> <20240926224910.11106-11-frederic@kernel.org>
In-Reply-To: <20240926224910.11106-11-frederic@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 27 Sep 2024 09:58:01 +0200
Message-ID: <CANn89iLLFJvoxjHhm_+pCkqDQeh3XUnztpO-YC+QKdPiK21WmQ@mail.gmail.com>
Subject: Re: [PATCH 10/20] net: pktgen: Use kthread_create_on_node()
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 12:49=E2=80=AFAM Frederic Weisbecker
<frederic@kernel.org> wrote:
>
> Use the proper API instead of open coding it.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>


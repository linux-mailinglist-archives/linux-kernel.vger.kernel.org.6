Return-Path: <linux-kernel+bounces-272290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C01039459B4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 10:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B235B22F45
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 08:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B84E15AD9C;
	Fri,  2 Aug 2024 08:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qIms1GT7"
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CE6219FC
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 08:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722586486; cv=none; b=NAHECDaKI+EisqXQxoTVpPwQr7ucNXmIPQzRTqkGusgMbbKiwFeOu/kSIbLJs8YsS35ZhKFWbiqeSFuw0yvPD2XZzXe55kI1QL7W1jFTG3NhbH1D8nmCY+aNotNFNDWRjVvUATREcbYlYTs0LU6wqLgG2LNXZ7KaCs9FNqGK/HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722586486; c=relaxed/simple;
	bh=1wD+XYUIK3zLq+OCozm5fvyCvQHC80UcV5dLYDwwafA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FB0qPVjIcUJPXWA6D9nXNIUeByzNe5vW7K/ai5JlA/en1O4o9sJtHTMHkSrxoqliefBcacTy//j4cdHGSgBldTnq+DKEhXb/tmfvc7yooMG4N5lj3PHDHLcYJZxlirfPd43Rx1dgGSHgMvp673QbwTWZztIBnDzDf5zpSbQ9KnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--nogikh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qIms1GT7; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--nogikh.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-a7a83fad218so599267766b.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 01:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722586483; x=1723191283; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1wD+XYUIK3zLq+OCozm5fvyCvQHC80UcV5dLYDwwafA=;
        b=qIms1GT7QW4sR++qUtH4b8AR5pfzT5ztWVie+IdBSbpqah7Pdjinx5Ery8Tvzs6tej
         202CsIcZr8rz8uDqv0gJdRqw+sRICWsWGvbvwMQrBp5Q98Dv4tLEV8xDXynF4TD99XFd
         CUONvfPmJdKUKFAJBpucTL2hKHPc+FfDlqBMtP6ezeoPhK/oZbittwWxgsC6zvCQZKfq
         1f3ft0XOGdmLZtgjfTAVbI+TaCBn/wggv53vK0Tm7+lVVx5oWaypvJHOwyAmUOuCPSpR
         WOhp5RRy+BuPLwb1QYMT+41FbjdMwad1t44VtHML7hfogmLVkc5gyyFtbPfnwiJTyIdq
         iZTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722586483; x=1723191283;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1wD+XYUIK3zLq+OCozm5fvyCvQHC80UcV5dLYDwwafA=;
        b=U0JMXCVIH558j33wFLkffEXxkM0AoE0FJp4tdlkpFqFN8hSqFaaKKr5XWWWDupORM7
         TGyp7E9farZXeQD0nucsmsAlLbMSYNZ+LLwPIyi06TDOT7yj2Sf76Npc6FjrSzttY8t1
         4ORbaMFJuRF1qVaiQWmschCelI479uWkj/wFnAnqOh5LvX0G6lhQ36ZnhJmUMelc8uAN
         dMn+rw0YQ1d/SDum6o0u8STrFWdT++BUmVVKL9e3Z/waZtuGX7FUdYw0jeOWRLV9oaSj
         IcTsEF1Dp48SPIRrUlJfnmyURTl6rN9N+tMscjS1toUtvcLn86qHPwD39qJMMzNxK9ai
         /yZQ==
X-Gm-Message-State: AOJu0YwymJ6vjQCESv0vtNCfXWBOw0EOy8b8CxYavv7YWfhZwadrRNEt
	AqrbKimUPo22AtKEVn72NEx+KkKQ/qwjnKYRBpIQs+cwqCnOlDEiv57CfgSagrWEwNPqZ1dWhx3
	j2Q==
X-Google-Smtp-Source: AGHT+IGla6MfBfIcnYAZcjX34zmqGdQNqdWUl9FDCy0e0HFC9ltpDOFoqKT0aBfB80LDjjtXfINNAS2vup8=
X-Received: from nogikhp920.muc.corp.google.com ([2a00:79e0:9c:201:b721:79ff:8103:3b25])
 (user=nogikh job=sendgmr) by 2002:a17:906:d154:b0:a7a:8448:ce09 with SMTP id
 a640c23a62f3a-a7dc50fbd11mr247866b.13.1722586483204; Fri, 02 Aug 2024
 01:14:43 -0700 (PDT)
Date: Fri,  2 Aug 2024 10:14:40 +0200
In-Reply-To: <CANn89iKY6JzgwDpANsniAaDUP8H1QXyuTzpE2YyRMXzwkSWRcA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CANn89iKY6JzgwDpANsniAaDUP8H1QXyuTzpE2YyRMXzwkSWRcA@mail.gmail.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240802081440.3961971-1-nogikh@google.com>
Subject: fix the commit name
From: Aleksandr Nogikh <nogikh@google.com>
To: edumazet@google.com
Cc: linux-kernel@vger.kernel.org, 
	syzbot+67defecaa74f7dd0a5d3@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"


Syzbot got confused by the line break. Let's keep the title only on one line.

#syz fix: net/sched: taprio: make q->picos_per_byte available to fill_sched_entry()


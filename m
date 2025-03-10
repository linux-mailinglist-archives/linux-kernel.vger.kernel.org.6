Return-Path: <linux-kernel+bounces-553601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E339A58C45
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 07:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2A753A7ECC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 06:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5F81CAA7D;
	Mon, 10 Mar 2025 06:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PY5IqiCk"
Received: from mail-yb1-f194.google.com (mail-yb1-f194.google.com [209.85.219.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580EC29406
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 06:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741589458; cv=none; b=G9s/AZTZK9BsRACywbvZVqWs4w/e/Ceu75odTfuoBIosebNcTkrEB7Yx9UcBFCd3eNMzMyNZQb3mpTdsmOuId2e8YCKKgXuNg3Odlx1Q4NdMffXGyZUwa1IzLiAUZh56qpJVAEsD9LrUwy6pVtkRiDYtWz5mt05FY9LRRLU3PpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741589458; c=relaxed/simple;
	bh=L0CYfzoaAwdaL7bmb0E3ECWujVkoCvyxy/bzqQJWSFw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=nypdmhg/UCsZ1M2GbgUCzrWFxosqoxzfAu9MhYVe0wWyvTQ9cSXzo4Z+YnicQ9FL3YCtgcPmOEGDzITOYAH9t87KQWWRNSiJqlVcSYSxe31rF03gGg3cwJzqET3lb5S6mhgEnWsRjRZuDbtCvXKAp0rIlRjozAdpT7MGZKnRgA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PY5IqiCk; arc=none smtp.client-ip=209.85.219.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f194.google.com with SMTP id 3f1490d57ef6-e53c9035003so3399348276.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 23:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741589455; x=1742194255; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L0CYfzoaAwdaL7bmb0E3ECWujVkoCvyxy/bzqQJWSFw=;
        b=PY5IqiCk+lD7I0SWIgVMSeZqaoXcyixNfSWDmpIFzFFSK0gwXZxma1LdMWGwuxeQhq
         m/C1ezi26iFIaVdjnTXcCad1cgDU5LItnLPqTNHUisRy2j9AVIlHqMSFaSb9wBQ4XskJ
         Bw14aECz/HevVqF0HK9HsyD0iQA3HHvZ8TJUYTApp+Xx6LDWdw0bqnqTEqWeO0KBJcD0
         rtcb8TZlcdl8YKMg8YH4NI3WAxNhCaCrDmSmvW5ACAwiCDEw9zB8paR9RK7wyPhV2roZ
         jM/tYvEbfFhzdrNkn5pPwqQJCTAD3DO5qbJFQdbyR2IxBFrz5pJrU054vKhAD7ZAcuGj
         WU1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741589455; x=1742194255;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L0CYfzoaAwdaL7bmb0E3ECWujVkoCvyxy/bzqQJWSFw=;
        b=BtYloZrv1WsvAl6rX5Qm8DElKyOE0FaMLXoC48gH0OKeVSqT72IvgoNeZcdMRxU0e1
         L5pqoVy6rbI4M3Om0BEqoKhjj3aei1bjytvv5jJbFf7vnCcoNBll1wM9b9aVCEavQpHp
         dd4aQskThW0o6K8CGVkVl8Kp2vquBi0rwz/k7JEii1zpKPOeTm5gBAjGk4rkcwSlT66n
         VwmYfjtEc3zA6zTxJu1dHEY/5gJSp/E/N1wIs0bxuVh+O+08K6GMQ4Vb1dZFl8lS48Ks
         kD8ki5KES2bVOI1RNlJGyT4fOLkFfDV0keJaqM6SGJRy44L/zl+UR5mWlNDzMkbCpg9S
         QErQ==
X-Gm-Message-State: AOJu0YwX0kleyjprvL3uqfJrEkmEoVA4e9xuWN/MIoJnUaRddWH6990p
	HUb7QE7NiMnkdv0sUtEvdTMTvWKqn0Q2su/Skm2pQIVGqds3dO1+B2xgAqhyiOWUDXxELsX/8Dd
	oD15u4mV7jRuF2MCEGTWcklF4LaR3vGd3dZ0h4JDr
X-Gm-Gg: ASbGncs53NXHH1ahml326Vb+s2C0kRgIxJhN/3sy89jqkQ3caAI0SprJNaaQzvDoYqa
	JwCka8QBBpJxrBoLZfv1XqyfG+uVQg6GWG5RhNbbsNfESHBq9tkGZed+PPV+U3NOL7rzxhnkc4A
	GL01zsX/VA6raI/Hr1FCHP1GgcXxmnbKw7LuoOyNj0uLvchg4jHpg9RmMFmEQ5
X-Google-Smtp-Source: AGHT+IHiPlWJExSQPX5J/QBVKyH1TStfEcIng93rIOF66xBcc9asAeASt7rw38KuYutfVROC0LlBK9PAfQoKJcAxmFQ=
X-Received: by 2002:a05:6902:703:b0:e5e:38f:d754 with SMTP id
 3f1490d57ef6-e635c13b440mr15884837276.15.1741589455045; Sun, 09 Mar 2025
 23:50:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Amit <amitchoudhary0523@gmail.com>
Date: Mon, 10 Mar 2025 12:20:44 +0530
X-Gm-Features: AQ5f1JpdR3JA0SAksHHVOJTIPNrBk--pLKEYqRQ1HCBcmH3WItf99vgDEgXBUVc
Message-ID: <CAFf+5zj8vfBnJ881BsfF3HUa8cuvCKW7v0Do5f_5Sg_kfhbGew@mail.gmail.com>
Subject: How to do secure coding and create secure software.
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

---------------------------------------------------
How to do secure coding and create secure software.
---------------------------------------------------

I can do secure coding and no one can hack my code. You can challenge me on
this.

Ultimately, all software boil down to functions/methods. If functions/methods
are secure then the whole software is secure.

I am listing the three main points of secure coding below. These points are
applicable to all languages.

1. The first point is that all the arguments to your function should be checked
always whether they are in the allowed range or not, even if your function is
called from other trusted functions. The value of a function argument should not
be unbounded, it should be within a bounded range. For example, you can specify
that the string argument accepts at most 1024 characters. And then you have to
check whether the length of the string is less than or equal to 1024 or not
(for this, you will have to write your own strlen() function, you can't depend
on the strlen() function of any library because the library's version will keep
counting until it finds '\0' character and by then your program may crash.
If you are using C language then you can use strnlen() function. The code will
be "len = strnlen(str, 1025); if (len == 1025) { return error; }". Similarly,
your 'int' arguments, 'float' arguments, etc. should also have a valid range.
Also, always check a pointer argument whether it is NULL or not.

2. Avoid using global variables. In object oriented languages avoid using public
variables as much as possible. In C language also you should avoid global
variables, but in case you need to use some, then make them 'static' so that
they are not visible outside the file.

3. Don't expose all functions/methods to the user. Expose only those functions/
methods that the user will actually need, rest of the functions/methods should
be private/protected in object oriented languages and static in C language.

Now, an opposing argument may be that checking all the function arguments will
take more time but actually because of very fast processors available these
days, it will not take noticeable time. On a 1 GHz processor, you can execute
1 Gig (2^30 or 10^9 for simplicity) instructions per second. So, if you are
checking a pointer for NULL then it will be around 10 instructions or let's say
may be 100 instructions. So, this will take only one tenth of a microsecond
(10^-7 seconds). So, time consumed in checking arguments is not a big issue.

In my opinion, if you follow these points then your function/software will be
secure. I follow these points and my functions/software are fully secure, they
can't be hacked.

----


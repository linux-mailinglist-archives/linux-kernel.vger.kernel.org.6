Return-Path: <linux-kernel+bounces-422279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E00CF9D96FD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 13:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 878A1164E78
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 12:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C23B1CEE97;
	Tue, 26 Nov 2024 12:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3N04oxW"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3800683A17
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 12:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732622925; cv=none; b=GC9CebgEphBTHVmxaa8DVFt6NghKmhyaeMT1/CvT1sRfPs8mng8FlCH8IXgCCmzLlDJYIKEuIMZ9ZVU4pkz8i0rXDtVGV5BzrYPRNNoeyMHPQ8CZKm9fGsRmIJibeVIkbbWOAzeXWP00iVN2cZfZ8mbPWlRAyPqnqHd9iRCsBHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732622925; c=relaxed/simple;
	bh=w3DNd9eZFiFuVOjSFy+tRo8pWFg9wCa5VYTvMm5av0s=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=An95ffChFAr4a09C03WtDI1qKv0u7/7/dA/WUix5Jlj7Uy1gfbYA0nx6IvO+zRCJWROZW759YIOt1d3IoPOw7oKU6NO0SI1XMDvyqNMn2sfKxTxnnVUkPk4B1Tg1FMDwJELTdHtnUfGYuOPjyFCRkXnQQq1NB5UM4AXhjjXvihc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i3N04oxW; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5f1ef6324aeso748571eaf.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 04:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732622923; x=1733227723; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8c62/I1cZlNPbc+p7CcBCcDlIhP6BtucEE7bum66MKk=;
        b=i3N04oxWGV6d1Ge1f4L4gJIO3PDI6bMTpze/i/n8jgt6lY3i0rHjtLn+6ZJaUDg2wR
         H18SOIddrBrN1OxiV9QBe7GMHOEgw29vmiK7j6pgfXQW4roMGAJQ3gz80ZXe3A7ZHPSr
         WYvrXw4FKsGSUDrq1NJBsoiZsXJ+fV0qIeF2cxJpf+Pj+0l5MuQBzAglNQY10dB11Geq
         x73zOeFCMAh8Xbqe0Fov6LkNXjQuXGrkh+020iQPmXgXfwgAt2CnVU5DiScboGlzkZ/w
         fyD1V8ETWNolUA0BUoeBf3nwX+4bzZANh6DSnFjBxovfu/5kbh2Mqzh9sAZ5a0BZRJOd
         EqOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732622923; x=1733227723;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8c62/I1cZlNPbc+p7CcBCcDlIhP6BtucEE7bum66MKk=;
        b=nBbCvb6oT58bbmQX/LukLzOhRCalgJT9wNnwqPlBEKEU3PpHD5ZwQ5DnbDhw4sYUa4
         ccWuJRddAu84uuTHL8AK3EdiLtOxNMG6/yh9I2eW7LsvpxiPcUFKqGrJsBtEnB6bb5JP
         OWM3IPZFnJS2QlukxhO3GME01ltzm+ILTkQgxgaPQnhBYg6yu5A5CD8D2SCHcp4WlGp1
         /iZAKqFQXdqqu2VKe+ZDBIdJCQ5rk8eMYXS3hKgokr7x+DNl4xcnrE1Za7YGC0SOR7+R
         0ydVBVZki5a7H+ajv4rNZ/5nSNEakvGVkIVOUPPi5e+AVg/I0pNZiL3qXY7tok45ButW
         UpZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmUhK7f13Qmt7i44n//IrxRTMj6lD1HsKAClkUEUZOt3m34O9B7RQxsxGQiS3j+dOm13Xxi596KybjQFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YybZxUfHLetUq5e+BO+M9c9PIQfrJgn/DW/tFK4QL4yGVq+U0KQ
	R2r0IEfmhqYduqT2uMBxbQ4PsLN0gk+RhpZuzqqxBXeIK3FtCkKtcVg4k6sX12VIHjdTtG1JGYt
	uqBD/jY69F6EwNLgqduUx0Uxts6k=
X-Gm-Gg: ASbGncvP9yyczRi3ex4xirLqqxc7xZ9RY4RrJWXuRZbREGGk7HVl61Vn1/RhypxHXB/
	SWyQoT+ijtbMwIs185VfhxWsIGmRC+cCBHhZzeib6cg==
X-Google-Smtp-Source: AGHT+IHgDiX+piy7PZ5AEYr/oQBwsQLhiVS+gr4VGtihNr9dakVFBM05UiN2LDKDVhiZjy2bcGhdxcZcU0XfYQVNsT8=
X-Received: by 2002:a05:6359:4196:b0:1c3:724e:f4d5 with SMTP id
 e5c5f4694b2df-1ca797cef6dmr932506155d.26.1732622923239; Tue, 26 Nov 2024
 04:08:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Zhang Zhiyu <zhiyuzhang999@gmail.com>
Date: Tue, 26 Nov 2024 20:08:32 +0800
Message-ID: <CALf2hKtQH9KFp=KDQo6jmq4jpNzqoJnJRAFKWHf=Tk62U6RaVw@mail.gmail.com>
Subject: Follow-up on Linux Kernel Vulnerability [v5.15] KASAN-stack-out-of-bounds-Read
 in gfs2_file_buffered_write
To: rpeterso@redhat.com, agruenba@redhat.com, gfs2@lists.linux.dev, 
	linux-kernel@vger.kernel.org, syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Dear Linux Kernel Developers and Maintainers,

I hope this message finds you well. I am following up on a previous
email I sent on March 3rd, 2024, regarding a stack out-of-bounds read
vulnerability in the Linux Kernel 5.15, specifically in the
gfs2_file_buffered_write function. Here is the link to the original
message I sent to the Linux kernel mailing list (but forgot to cc
syzkaller group):
https://lore.kernel.org/lkml/CALf2hKupR6mV4vUW8tWEJY_1CqaLLrqx5q2667XGEzEGnAtuQw@mail.gmail.com/T/

In that email, I attached a detailed analysis of the vulnerability,
demonstrating its validity and potential impact.  I have noticed that
the issue is still being triggered on the latest 5.15.y branch, as
reported by Syzbot
(https://syzkaller.appspot.com/bug?extid=43147f1cd55d15dfbf7d), and I
would greatly appreciate your insights on whether this vulnerability
has been fully addressed in subsequent kernel releases.

Additionally, I would like to ask whether a CVE has been assigned for
this vulnerability or if there are any updates regarding its
resolution. I also want to discuss the CVSS score for this type of
vulnerability, which seems similar to other stack out-of-bounds read
issues in the Linux kernel (e.g., CVE-2023-6606, CVE-2024-39487,
CVE-2024-46743, CVE-2024-50227, CVE-2024-50301), all of which were
assigned the CVSS vector:
CVSS:3.1/AV:L/AC:L/PR:L/UI:N/S:U/C:H/I:N/A:H.

Thank you very much for your time and assistance. I look forward to
your response.

Best regards,
Zhiyu Zhang


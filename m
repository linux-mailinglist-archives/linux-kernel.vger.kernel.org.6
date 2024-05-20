Return-Path: <linux-kernel+bounces-184018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC308CA175
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 19:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE67428295E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 17:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCB41384B0;
	Mon, 20 May 2024 17:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nuDGLLJF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAAC13849A
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 17:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716226529; cv=none; b=Y2qAxPlFVNSBU0fe2d9dXicws2Xshq+Xq9Bg9XeHTZykAttB8Ik2jFMXv48yzX9WzWP1SbAlfH8HOhGSb9VwA/yvoT8ojoKMTpwV5wVc06s4vG6X/esw0xe9+qqN8T/KxfRC3nehNW9rjmPo1NLhVIJBTjoC8RW+TEhZMES10UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716226529; c=relaxed/simple;
	bh=O7+CYQOd/w839bO6PiOykmWUcQlJRwbbfX3QEguy//E=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=R0oWDG73am9Axqd8eTd7AM/qDX/ZVKx32fWoKk0x89Lay0UkHyWazZN4qFJV+agDSTenVxLApbp6zfLC9eU2QXyRJiD+YUm8qgVecpuSMVw1paXzLm/lof/OWE0RjTLijLTh0H44FQfZgUWly2wqtgq5L/SaStkyIWQnvVtgbj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nuDGLLJF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53B92C4AF09
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 17:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716226529;
	bh=O7+CYQOd/w839bO6PiOykmWUcQlJRwbbfX3QEguy//E=;
	h=From:Date:Subject:To:From;
	b=nuDGLLJFfcfJSmsa7YGYNP066/Kfl+wR2NaMYNmr0W7QjtqSuDy3DLxsoUJ/lS3GN
	 eBEb5RZIZIsrQm10nwiRMa/zmaFmOJrcYrb8MWPnipoT9sXm1mPT1BgEYjbGETF4Wl
	 2dYzeVDJnEBfWM+smXd49DGIL7zoKronxmh6ON8GmCyM+i+giZ/oKfPgQoYztRmTTy
	 A8wH5dZXqKvnUU6HJMahZ0iCLrfrdxpWqc1zfay1WAFBakyf9PmA2WH8NMe6ZCRZBK
	 aNx32zJ42cPMilEK/4zY6aEh1NWggvTNFpcC3zyQsNzpRQcDzR5/kYEYDqZgl10ADH
	 DxNWDh5qDwPIw==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2e6f51f9de4so36864871fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 10:35:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVR8umSPnuF+2Z71pFdL72mNS+CApLBk2y9XFuxWzkzocFCrqciJl1am45dVgSYYsC7inS9kOYrm8yd+ApnhejZ7Z4asT1c+h/ZKnb9
X-Gm-Message-State: AOJu0YyERkY4C+5LfEOj123X6B3DiJ6998vGa4dMpv1VhgEEpn+6jUOx
	3unIfHAvEDaEanOBm3v4Czn4+FjlIZNcFcmIezOkkK0lcTb2wuzM1EoX6zaP+2+8441vQfBSzNw
	/LxYss5R0AldVD863iu9TP5eto9M=
X-Google-Smtp-Source: AGHT+IEEQtQ+5mZ2a1FVID7q6H6mM0E87SjuizTn64cm/IbslYG5keHfdkxyYT+ArXTNfvOhORojpSU2hhJt5p5FLf8=
X-Received: by 2002:a2e:9601:0:b0:2e7:1e4a:31e0 with SMTP id
 38308e7fff4ca-2e71e4a328emr37507561fa.18.1716226528039; Mon, 20 May 2024
 10:35:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 21 May 2024 02:34:50 +0900
X-Gmail-Original-Message-ID: <CAK7LNARXgaWw3kH9JgrnH4vK6fr8LDkNKf3wq8NhMWJrVwJyVQ@mail.gmail.com>
Message-ID: <CAK7LNARXgaWw3kH9JgrnH4vK6fr8LDkNKf3wq8NhMWJrVwJyVQ@mail.gmail.com>
Subject: ftrace/test_ownership kselftest fails in the second run
To: Steven Rostedt <rostedt@goodmis.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Steven,



If I execute test.d/00basic/test_ownership.tc in a row,
it passes in the first run, and fails in the second run.


I observe this on the Ubuntu 24.04 (6.8 kernel),
and also on the latest linux-next (next-20240520).


Is this a limitation of the test or a kernel bug?



vagrant@debian:~/linux/tools/testing/selftests/ftrace$ sudo
/ftracetest test.d/00basic/test_ownership.tc
unlink: cannot unlink
'/home/vagrant/linux/tools/testing/selftests/ftrace/logs/latest': No
such file or directory
=== Ftrace unit tests ===
[1] Test file and directory ownership changes for eventfs [PASS]


# of passed:  1
# of failed:  0
# of unresolved:  0
# of untested:  0
# of unsupported:  0
# of xfailed:  0
# of undefined(test bug):  0
vagrant@debian:~/linux/tools/testing/selftests/ftrace$ sudo
/ftracetest test.d/00basic/test_ownership.tc
=== Ftrace unit tests ===
[1] Test file and directory ownership changes for eventfs [FAIL]


# of passed:  0
# of failed:  1
# of unresolved:  0
# of untested:  0
# of unsupported:  0
# of xfailed:  0
# of undefined(test bug):  0
vagrant@debian:~/linux/tools/testing/selftests/ftrace$ uname -r
6.9.0-next-20240520





-- 
Best Regards
Masahiro Yamada


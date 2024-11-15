Return-Path: <linux-kernel+bounces-410667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 999C79CDEB1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 13:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4703C1F2415F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 12:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DF81BD027;
	Fri, 15 Nov 2024 12:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JOYCVww6"
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7A41BC073
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 12:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731675227; cv=none; b=e/74IjIcmQ5INM3TDpLzMySb7RtyWxJuwW2xYWM0m5xHzn0r/OKuEd+SiDC1ScHXirPpB8rLuPA+mt/iDkJG88f9Usw8LFRATbFbGHmgmkv2dwPNkFLPWI4S8VjjOlHlvoHhk1LIotBfWLwLfy1EH2rFip5GqKEyiNXeSWDeQrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731675227; c=relaxed/simple;
	bh=kC5b4Nc50fbhWMMi5vOolJEMARSuns1Kxgz8mfrxf0I=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=IHxavAAV/L0NzjVpCbqRm/v9vlNiRBDYy6CYLhfViQs/+jeW04Xnxl3mP/sGgIjk/TNCTa1k56JxaZK6SNoan/RZYFIgG5YM6lVyT2qUlqoxcDdSS4HlKDoMd+LmToyUtQUw0YWoXdb+I5CDPKtM1ATQgqPowsuyOh3evBeWMMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JOYCVww6; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5101c527611so806245e0c.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 04:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731675225; x=1732280025; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NEbeDGIYvAwvzpGJm9/Bl8sSZPwTY7aHupGksBQNqK0=;
        b=JOYCVww6pa0/5KMRFf7IGJ1k+Bx7LGT2/DxU/Oh7MNdjqymjq/o+5p3ba9kuMh9sK/
         7l4elYOAprk69/Lmefbspw0vxYX9VhssazXRk3pCzS+r+D4GrzConORSUl9UjQy7uhPw
         lwj7ArJehnwiEWGkBKfMkVHBvZomFHfcS9WiNzkJvCT726uwflO0CSfn5JFUZhj16KDA
         IfHY7JUeOeDYbJmazpt54Eh1uN+gHcGrvm9mmKQjvuOSkjgB+ONs+XqfPRJYEiRLJL6J
         Wsk/TlEKWepuq+Usys4p/DwxKcDYNwCt0m3+ql6lrCw/7u/T29IksxV93BxQRCZElXUG
         sm+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731675225; x=1732280025;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NEbeDGIYvAwvzpGJm9/Bl8sSZPwTY7aHupGksBQNqK0=;
        b=piWFcV1MG2K54aWcbIzaUPOTua+1bM+cepP66dqfuc4LRpidCkLqa2x1p3vsxy+g8h
         qRopaPS30WlCEwU+qdpTQHP+ZwkSyr3SAcP53jxTo5aFVKd68M5MdEBFfjxsGHua+fD1
         7V6sEzncPjK4A+ib7Z6ucNj2RQCbk+elfOfklbniZIJ8YYW3eQJvlQCTiwKnNQofpFQZ
         CnDbuO7qkcQqZGkSDo38+Xw3XHkUF4IksLUCLSQz+yvKtz/YjRRETeNpaTjqhp+ibr+U
         yzxxzOKyE9v7qFf4AaLYbEdLqjlByThho7o/AnbgACqFw4MMf1hyjJbQu2hw/uLQKind
         TJ4A==
X-Gm-Message-State: AOJu0YyrNMcZot23boPY1WGCsYSGBbWecqPgF0jIx58jct7+kDfF4pez
	qeMw0F04hEDAyidYKGnvVc/EjZ9hxhe2GxEnFeVCzNTrDYV26gRZW5U8CBeh+pcHyu32lHZ1JUr
	P489nS8TzuMEzMLasX6Pff6AFvQNbGQHxydkkZAagNeukbvt1oeA=
X-Google-Smtp-Source: AGHT+IEtDEtXKpcCidRqx6bebqrisPTC0Px9Xm1sUVNWuLsQVQUre+hBcxnbLyeeXGplNKk47hIC4CRTO6saY/xxXGY=
X-Received: by 2002:a05:6122:8c22:b0:50c:79a4:c25 with SMTP id
 71dfb90a1353d-51477f7c9f3mr3308737e0c.8.1731675224854; Fri, 15 Nov 2024
 04:53:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 15 Nov 2024 18:23:33 +0530
Message-ID: <CA+G9fYtThFpgHJvVwmvp274QJ0QBbrsr+qnYi0b5fWJ5oJL2uw@mail.gmail.com>
Subject: next-20241114: clang: fs/netfs/read_retry.c:235:20: error: variable
 'subreq' is uninitialized when used here [-Werror,-Wuninitialized]
To: open list <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	netfs@lists.linux.dev, clang-built-linux <llvm@lists.linux.dev>, linux-cachefs@redhat.com, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>
Cc: Arnd Bergmann <arnd@arndb.de>, Anders Roxell <anders.roxell@linaro.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, David Howells <dhowells@redhat.com>, 
	Jeff Layton <jlayton@kernel.org>, Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"

The following builds failed with clang-19 and clang-nightly on the
Linux next-20241114 and next-20241115 tags on x86 architecture.
But the build passed with gcc-13.

First seen on Linux next-20241114 tag.
  Good: next-20241113
  Bad:  next-20241114

build:
  * clang-19-lkftconfig
  * clang-nightly-lkftconfig

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log:
---------
fs/netfs/read_retry.c:235:20: error: variable 'subreq' is
uninitialized when used here [-Werror,-Wuninitialized]
  235 |         if (list_is_last(&subreq->rreq_link, &stream->subrequests))
      |                           ^~~~~~
fs/netfs/read_retry.c:28:36: note: initialize the variable 'subreq' to
silence this warning
   28 |         struct netfs_io_subrequest *subreq;
      |                                           ^
      |                                            = NULL
1 error generated.
make[5]: *** [scripts/Makefile.build:229: fs/netfs/read_retry.o] Error 1

Build image:
-----------
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241114/testrun/25811023/suite/build/test/clang-19-lkftconfig/details/
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241114/testrun/25811023/suite/build/test/clang-19-lkftconfig/log
- https://storage.tuxsuite.com/public/linaro/lkft/builds/2opUctayqtTsKWUeLDYKbGaUqa9/

Steps to reproduce:
------------
- tuxmake --runtime podman --target-arch x86_64 --toolchain clang-19
--kconfig https://storage.tuxsuite.com/public/linaro/lkft/builds/2opUctayqtTsKWUeLDYKbGaUqa9/config
LLVM=1 LLVM_IAS=1

metadata:
----
  git describe: next-20241114
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
  git sha: 37c5695cb37a20403947062be8cb7e00f6bed353
  kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2opUctayqtTsKWUeLDYKbGaUqa9/config
  build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2opUctayqtTsKWUeLDYKbGaUqa9/
  toolchain: clang-19
  config: lkftconfig
  arch: x86_64

--
Linaro LKFT
https://lkft.linaro.org


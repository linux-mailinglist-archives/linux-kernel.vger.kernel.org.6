Return-Path: <linux-kernel+bounces-173306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D72548BFEC1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 15:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 786B61F257DE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5202179DDB;
	Wed,  8 May 2024 13:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="DFQkHr59"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7382278C97
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 13:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715175019; cv=none; b=QF7vq1WDCivT3J8qLIgR10L+B1w3GY1LmV817TRp9nX89eufcpSq1nV6cbbYjJobbqTtEpXQkz0GD1TJRz/p1/U9nIy95aQT4AtV7iTdwMYpbIHLOrugHN8wIlZqLesS3OxrQ3rj+tSm/3bE8gX0sk4lte1sb0N7RSzfy6zNp5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715175019; c=relaxed/simple;
	bh=akmpdCt9PZJBsPQVJ9q8HZ+ova6kEltuOv/AcpY1sBE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=NueaBH6aarMmwcQz+KnPLTkwdpZPdKlLSeYfuOsCpxPke9R+iZez5jFQ+lhSre5w55+ZmxERI4Phcci7ED9r1k7Gxhclbqb6vMfpEY7rqCxRMdPRMIyA4ADXxzMVrfElOxTc5VQifarslDHiG7tW8iSNTupYthnM1JUo303pNXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=DFQkHr59; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a59a609dd3fso149711266b.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 06:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1715175016; x=1715779816; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nTmp2G2dqhkUnf1OiPwHt6oMVXv2UiakGWOKDLhbP8A=;
        b=DFQkHr593W0pqz9TF3KYSgrbxQ+3dGHpsdKJD1MvbUs6cTxFPzTENCHgT9baTxu7aH
         S7Dn4qAV98zIoMI/OKlAx8AWiwsd+rOOG7twZcNkNsJjOWoFsSDN5bxutQarl5EEUem+
         79XQ5eS1Jho5atBhETvTbO9QTtsMLaAIUD40s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715175016; x=1715779816;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nTmp2G2dqhkUnf1OiPwHt6oMVXv2UiakGWOKDLhbP8A=;
        b=tuIluOUqWCPg0LgcwE6/UaLbMH41wcGfAj5yklJ1m8dhbDplAxkd8/BkxJZfkX/ZI8
         fUSwgAW3a0L39eMXyctz8B9rMQImjZjwe4u9OrYoY3AnMwIaruulNITaT6PvSMYu27wC
         ukfzqPwfJj8Dav+rbqGCnUkmJPk8QisawBammSk7urOOGEsRL+wa9QcYJvn1rqSixlYb
         pet9t1CqjKCrGnBNKkfQYlQ2GlaDlL0yhE9f9adWDfLZ8Os90xfNfSxGw1877kzqo0Jr
         d5pU9xcnZVgVLDCZf9Esf+eTvBH0aZkdBQb6tsVK9VzgWy0566yjbboq+ngeRD77xfK9
         eZYw==
X-Gm-Message-State: AOJu0YwJ74hq6q32TRGQt4ZHowfDPEFcSgsA/9+JC1144LGsMWG7tT5P
	YzLO1cs003XgJqS5kL5qn5pWznqea4FI2RiAASiNd/5Z+cqqESAIGfF1UGEeib5vMNGtEaejypf
	vnBn3yWZ/UboObig3y96vB1XX4/heLaXNiITOepvPSau+jz01
X-Google-Smtp-Source: AGHT+IEniMP8c35DPg+c32/P+V27cSLn810RvFXG8aas43eYWQa/g100+wlMJIeD1q9cFqtyRt9cPoNAkSKL4zOBDpM=
X-Received: by 2002:a17:907:367:b0:a59:9db2:e2c9 with SMTP id
 a640c23a62f3a-a59fa88999dmr234427966b.15.1715175015612; Wed, 08 May 2024
 06:30:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 8 May 2024 15:30:04 +0200
Message-ID: <CAJfpegvtjodd03R4KjaMg=V9gcCHK3Js3GP-s-8QRcpTJ_TMQA@mail.gmail.com>
Subject: [GIT PULL] fuse fixes for 6.9 final
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
tags/fuse-fixes-6.9-final

Two one-liner fixes for issues introduced in -rc1.

Thanks,
Miklos

---
Amir Goldstein (1):
      fuse: verify zero padding in fuse_backing_map

Brian Foster (1):
      virtiofs: include a newline in sysfs tag

 fs/fuse/passthrough.c | 2 +-
 fs/fuse/virtio_fs.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)


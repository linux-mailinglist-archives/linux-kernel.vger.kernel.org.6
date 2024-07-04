Return-Path: <linux-kernel+bounces-241481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE85C927BB9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 19:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79DCB288F10
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E51C1D363D;
	Thu,  4 Jul 2024 17:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2woQ2Q/"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6671B6A4E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 17:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720112984; cv=none; b=K2tVMut1ZKynll2ivT/sLAiphzqArVwiCk4h7bFmYG7CkddkHjCtalalnEWpRvlNIdSmazp4VAjZIFuM3RV2Q6Psp0BdpbbBuLBojFOzuZwFzx6q7BuXZZa4vJqIbZp3l3Ogop7WdhihtBYFHV5eN40h2Mh0VBqgoB+r3cdIAH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720112984; c=relaxed/simple;
	bh=/XEYZ/Q0r4fTu2Rwdcss21ESH6ZuEDumpIjOCEd90UY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=mSHtp0vOkILb7rSVlfO1Fn2eKwGGqoCRdQO2sc6j8+r3oLUeodse5MwGHe6KkVeQJ+9njwjL+gLw0cEvvBhgyw9DvLHKXIE1M+vyP+9IW+jvkh+cXa0c9sfBlpkFCtd4hpr25j998A9+8twny4EAVRPUTpo5yUxohID6CLcAovc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y2woQ2Q/; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-702233310b0so490629a34.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 10:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720112982; x=1720717782; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/XEYZ/Q0r4fTu2Rwdcss21ESH6ZuEDumpIjOCEd90UY=;
        b=Y2woQ2Q/f8Tm37y1de8t3XYiTC8ugZC0pI9i0Vo8CNkJm9w1X4HF6qR+fGtZpgAzA7
         gxzoTNbxJLn9Mi+EOaBHH6fgvzcqRIDbt+YqxnvAdb1SaCe1HzWj7rXhoeyK9Bsyasbp
         82/o7RYW5R2zECWGROSrrY1HvOo+6EGbUjIHWH+R51PkhedvIzZtZGXNOpV44c2heitr
         Wm2OlVT67/XbSnmWaFf3lbve4k4WepHz4ZiuFHql7seZXH+ATChSpTq+r4UoqqrjdSx2
         nG+57omQ1Y776MTjXmxu3Wh9R8ahGmY0zx+EigdLR1WsgLtTm1d9zjKTyt87vHTaxULQ
         C03A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720112982; x=1720717782;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/XEYZ/Q0r4fTu2Rwdcss21ESH6ZuEDumpIjOCEd90UY=;
        b=gYZBpBYGA01ia/dIQ2QkCz2mcCGKOuxLzp57kxkML4L9PmuKjOqYbs9Bx3BZxtPgTC
         HJRLBJ0zpdPksE7iviAfQrPr4kyjIgcQu2HFsS6GYzD18kwJ/BFfP9QqHZ85dhIF6E99
         TD+wGfDPtGo+ZzRVHYKHjrbAL1XPhMNInYjN2j884oyhu40UfmWK2gIc84gN1EQSJGwZ
         SYPYOQwOrI5j9cWMPEL+mvYxmZAem+RUcluVqr6kaxrqLCXgSACQcdIt3UwCM+ioic42
         eBdJpgN9hjhrayJ5nqFJE+XIAD970hpbRY760AIjPIoy4JlTHkJYlob6txC9tBnymNg0
         0ppQ==
X-Gm-Message-State: AOJu0Yz2wkQrAQ0fmz9htaQx5oMCVnxOMMmwDUgT1GaXx6ipnNYR3QPG
	Ppy6LJQbFtiLpmsne7hMim5djJFHwuLY2c10+8YpxM/fwVi6z8xF3Nrzt7DFyKfYJLEostBHWHL
	4tF1APrQLyRtuN27vynbqSWJ9UNCqkdgj
X-Google-Smtp-Source: AGHT+IETKccMWdcBU78kkxs8dZPxmpUuSrvPp9n3Lr/sInZfAcbU0oBLwzBuQjIMawJSqCpO2s16zB/eHpGu5jC4ONk=
X-Received: by 2002:a05:6808:13c5:b0:3d2:1f5d:f992 with SMTP id
 5614622812f47-3d914c82836mr2589988b6e.32.1720112982424; Thu, 04 Jul 2024
 10:09:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Thu, 4 Jul 2024 20:09:31 +0300
Message-ID: <CABTCjFB-Bcf4h+hq6xaD3USFDG4LppwBuuUU8XH+SDjpado4nw@mail.gmail.com>
Subject: Word delimiters in C code file names '-' or '_'?
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

What word delimiter should I use in Linux driver C code?
In many folders '-' and '_' are both present. Which should
I prefer for new drivers?


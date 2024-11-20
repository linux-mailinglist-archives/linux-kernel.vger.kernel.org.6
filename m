Return-Path: <linux-kernel+bounces-416374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A79189D43F0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 23:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C17DB219CA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 22:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475C61BBBE8;
	Wed, 20 Nov 2024 22:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZcC297ut"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CB8188717
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 22:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732142050; cv=none; b=Cy8W5h9miIHrVkvqTRAgSJB4Z2AUUwy5j6TQJhu6bx6GcNMeG6Xh5sC/0pk9ph/L1gIHhxO8C6JLQ/JZKIK+jP4xvrw3dlws1nc9l9IE3IJ8p0Rc0/e7mYWb5OjaSGeUbyN8Sq2z6Va+ygRqtm7cV+WM7AueC8zNKjzasybcsvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732142050; c=relaxed/simple;
	bh=MAgElEzxnFw8lUEu8ifLbOlGP0HX8ch3eDwmOz/StSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=coOmlhXxtev8EP5HlgZMVn2hPxRrkF5kaiQltjhwQBTOncqqH/xoHeaw2IQPVMX3tHGKCXGvzPR4b1rXwOEURfdvDvqCXOMxlaZfO6IuUCdBNFGG5bN6g9mj4ub6ptNPn+JV6PPz5NHaPbRd1cFUG0C4abFy1qJplqcG0u9TmpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZcC297ut; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5cfddc94c83so267353a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 14:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732142047; x=1732746847; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IE8ZQOZriO9yiRAPmOhdaykylbaaL2C3b8EX+PHDvps=;
        b=ZcC297utq4UWG+8wIszT1pvMZHFw2Hq+LAOpxbVifoQ9iIRn4OJjgxK3p2IyT129d6
         SxUUM+LA+bCSBXlVg2UmgP01BSlBWOW0/UM0iGwky62RCXFG6cg8Fu5HOUXQwlS1YVQj
         zyXngk1Hf+MlRH5yk88+LBFbS/7z5hZSEuyLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732142047; x=1732746847;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IE8ZQOZriO9yiRAPmOhdaykylbaaL2C3b8EX+PHDvps=;
        b=aBDiIC+usaRp2VyaTytsrxJV0NtBYjaCfzsvQFXw+VYRiDcWmlWeZwHpUU4i7t8bkJ
         +pqV0KXf77NGeeeFEmutrV76PqDMEC7/g2V4uhyRVv7mXGRm5au2/msVO5Cn8UtVrpVo
         K8Iv0uiu8SWcrDK+zshBQd5maAksqi4iwxkOzur+OyTWtcqtAO/0SmUDASOzLJRFCltX
         nqhLiLoFUuraIbVrwvxTq0ARCZSemnAlop13Zdm6T+sA6xzVSnU4+lk5nsNXZuWnT61d
         8h9XWRLPH5HNiORi/5ja85oQrPAYkCAX3H7sQBBJbeZnrSSOymn9Q6nAr5f5AT+yrHNu
         YBIw==
X-Gm-Message-State: AOJu0YwVKbnYR82/9qNyTGCMqvdSB4yA2DLdaNB0Vkhqiv0/I0I1qfZ+
	ohEzc5VMjJussijMIefLlg+GWQnU2MSpY83I26087NNOzRGIXH0uSGVSnSQLTp3OIs5G5Lb/KLy
	vpOsEpA==
X-Google-Smtp-Source: AGHT+IGT/s94Vj7anEAqvt9poIyjY4Lp4DlSH+GcDy0NXDG5ZGtit21Lq/xReGrTkBe+fz9xLgUdPw==
X-Received: by 2002:a17:907:96a1:b0:a9a:15fb:727a with SMTP id a640c23a62f3a-aa4dd55186amr408185266b.13.1732142047077;
        Wed, 20 Nov 2024 14:34:07 -0800 (PST)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa4f437ff05sm6919366b.191.2024.11.20.14.34.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 14:34:06 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9e71401844so37432266b.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 14:34:06 -0800 (PST)
X-Received: by 2002:a17:907:d09:b0:a9a:eeb:b263 with SMTP id
 a640c23a62f3a-aa4dd7527ffmr414235066b.58.1732142045753; Wed, 20 Nov 2024
 14:34:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202411190900.FE40FA5@keescook> <CAHk-=wgB1L75+C89AU62n4jBEiwKs=e4dvBDOoLQ13rUwJLFXQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgB1L75+C89AU62n4jBEiwKs=e4dvBDOoLQ13rUwJLFXQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 20 Nov 2024 14:33:48 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjPpuThc4Wbtk-aUz4buUSH9-gvsmjT5P3=2tU_Kz8oVA@mail.gmail.com>
Message-ID: <CAHk-=wjPpuThc4Wbtk-aUz4buUSH9-gvsmjT5P3=2tU_Kz8oVA@mail.gmail.com>
Subject: Re: [GIT PULL] execve updates for v6.13-rc1
To: Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Dan Carpenter <dan.carpenter@linaro.org>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, Nir Lichtman <nir@lichtman.org>, 
	syzbot+03e1af5c332f7e0eb84b@syzkaller.appspotmail.com, 
	Tycho Andersen <tandersen@netflix.com>, Vegard Nossum <vegard.nossum@oracle.com>, 
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 Nov 2024 at 14:32, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> People: we *have* a filename. It's right there in the dentry. Which is
> right there as bprm->file->f_dentry.dentry.

... that should obviously be '...->f_path.dentry'.

             Linus


Return-Path: <linux-kernel+bounces-359985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E96E999342
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 21:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8030EB29CC8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 19:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B9C1CEAC7;
	Thu, 10 Oct 2024 19:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2Fs28wP"
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A2F1CEADB
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 19:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728590192; cv=none; b=pofzB/4+7FZY5pLMWlYf/O52aJcfKw3gk6mFM4DNKQM86tvKDy8zlUiv4iq2UymFC8kOKgPDiJqzxS7eXxDiIRUQ8eFt/vSqb7CcgrXsuXc3pw0oDcm0XLoip20C+c51ofiMDKDeqAPIZYz8HqCnD3Bjz/7ZGe4P9tarIwOl2Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728590192; c=relaxed/simple;
	bh=6bMhQ6vS4IBL5G11MHPbX4blmNf/jwNV6R3qQIiP2y4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dSHsCakPJyguNJbDWi7Vc7Zvv9m2GCq15ajAouVtobaaVsQYr/zMKaIIvkDVXJvlSU/SCwxzrZ/NdYkjuR7rOEi/n2qBwTd4//68e6u8znkFUeK0jwa8QyguS4UOreYlr0BJzq5lmcTUVWejhhW5MJRbsGbT+DlnBScOkhNZQNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g2Fs28wP; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-50ca1581a1aso428610e0c.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 12:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728590190; x=1729194990; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ll+zUf8+pVpggXRhbcBYKb1wpr1Jta5nrzpQw3NsDzY=;
        b=g2Fs28wPDBB8tK4S2kw0GJLhaSv8eRLy8/iwP7HWOwkrKPB889tN3mvF+rAJc5hVVm
         p5Sh4X2Egh7qjPi7NbqB2qzqs86+bfSgOzN+Tqz+s34YnhWq+zuX6srd+6kbeKt5cVAU
         9W3fPUPcXcd3vGwujtrS5MX1m4u5kRQf6YtIacmaCEBadS58rzKkxIRlYnJbOJpR+3wq
         fJBo9iX+meUab8IfV1gPHZJ3YddWhvLMR5PAjoqYPB84QfIFtW381bOObMgmKATA4+ef
         QfkiJ9twlqDAi+UmU4pXf0ngiBMyyBEcyvQE9kUzp/vcZx8Thli6rS0Ecbie1ZwdIhMq
         bUmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728590190; x=1729194990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ll+zUf8+pVpggXRhbcBYKb1wpr1Jta5nrzpQw3NsDzY=;
        b=o+HwVXvQDTVDk4ASnr93F9DmNVIyKQ3u1QOoiNDSiMPwrXq0LXOvH92g0HRpHbfH4j
         ilvEl8TuT84sGRYVwoUXb6FaK9OzV5O7k8UOCwlfRulVt23OqVkyNS3ObywDkw2WmI58
         H9lM9+aF4pyxHzlfCZHoarPpt1a59RKGxgeuokxWfZ4hmLpUuR6JeGepxWfMoUcnpR1d
         OWSR0jx9L+7jYq6FN0IvhGuFry+pUIMC/cEcuKKnlb0gMeD9dALVn23SSv1t/6f3eMBQ
         JhXsRbJ1j4XsYQhtDwGMZCr7Q1SFmEzEi+TJVVqY1E2a0wXnNKodt9DDT6gW4wWUlxqF
         +JJA==
X-Gm-Message-State: AOJu0YzGVUQ2Z/+5daDZw/5sQ0aJQDbYWwU2ST/QfV9WdEXOrz4C7xd/
	oaV0BSCV56yV9CN1cp4lubsZPjYA/+PgMeEu7JIEAx1+3pzeUw/nr5ohgsnvglSIJwHQ5ZWZSpc
	Ggg6PZZKqvbP2SUCq1/6DE6DrUsY=
X-Google-Smtp-Source: AGHT+IF0FbgxcM0z3IsnyEWo6M4VFT66JVWSxbkmp9oUUF5mXwopBFUspVDLMVlV0NkCSPtXgjkq8tnZyI51H1M8X5I=
X-Received: by 2002:a05:6122:a0e:b0:50a:8cb6:e9ca with SMTP id
 71dfb90a1353d-50d1f4c9334mr23402e0c.2.1728590189800; Thu, 10 Oct 2024
 12:56:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010000923.1278817-1-jaegeuk@kernel.org>
In-Reply-To: <20241010000923.1278817-1-jaegeuk@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Thu, 10 Oct 2024 12:56:18 -0700
Message-ID: <CACOAw_zuRue4baJczA1o7Uip3Wm=JN14p98+Kqma-VL39_GNaA@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: allow parallel DIO reads
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Daeho Jeong <daehojeong@google.com>

Thanks,

On Wed, Oct 9, 2024 at 5:10=E2=80=AFPM Jaegeuk Kim via Linux-f2fs-devel
<linux-f2fs-devel@lists.sourceforge.net> wrote:
>
> This fixes a regression which prevents parallel DIO reads.
>
> Fixes: 0cac51185e65 ("f2fs: fix to avoid racing in between read and OPU d=
io write")
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/file.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 71d5ded9eeda..adc7d64a6f47 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -4647,7 +4647,8 @@ static ssize_t f2fs_file_read_iter(struct kiocb *io=
cb, struct iov_iter *to)
>                                         iov_iter_count(to), READ);
>
>         /* In LFS mode, if there is inflight dio, wait for its completion=
 */
> -       if (f2fs_lfs_mode(F2FS_I_SB(inode)))
> +       if (f2fs_lfs_mode(F2FS_I_SB(inode)) &&
> +           get_pages(F2FS_I_SB(inode), F2FS_DIO_WRITE))
>                 inode_dio_wait(inode);
>
>         if (f2fs_should_use_dio(inode, iocb, to)) {
> --
> 2.47.0.rc1.288.g06298d1525-goog
>
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


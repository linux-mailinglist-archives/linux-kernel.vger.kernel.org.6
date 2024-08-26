Return-Path: <linux-kernel+bounces-302069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B22295F974
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 21:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07A09281D69
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 19:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48B2199234;
	Mon, 26 Aug 2024 19:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="fBD2qIrM"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F6018E058
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 19:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724699575; cv=none; b=N0Vlrv6eSnBAqDDSrlCPu3RhGf9J8ZrWaxsCxFIb4kJaNaavwMQxqabrhHJII2mkIb9YclVh8KFnBr8qgVMS5VeW9eUudu+eZHyMwnyi6k9tfzrkg0HP6nA0esPoeZXYrbU/HhAWwgvkE/CcfR3IUFg7GXdnffU+f3nYvP7P3LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724699575; c=relaxed/simple;
	bh=mnb6zYJ54fx22cuDC27883ytXeWKR6BtVeg16VP3ZcY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YhFMrxprmytqLIOc6gSEk73JvlQvIx+EusPo9FEDWIuNXIl2QySvDmVXHNT6qMyGVUVrlEy2OJhgRFtES8uHRU3RW6FvoU7WvrZlcBgz9RwE20EqfcJvdE7ffwSXQS3toFesOrLiHuwoAuf8ifOoCYmKYrhQ3SbyZ9ZMLT93Ibk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=fBD2qIrM; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e115eb44752so5023490276.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 12:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1724699572; x=1725304372; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mnb6zYJ54fx22cuDC27883ytXeWKR6BtVeg16VP3ZcY=;
        b=fBD2qIrMHJ1Lq4HMx99nVDqXs/Mh/oOvCcSGGZDbSvDB0wKCO0NUtteOpr+7cbK82A
         0zkzs01yrgKrjX3LQcDdPLzODhIyMsWWMEHonfsN3pDhL53GU0nAUI01DAlzpTWdet2u
         JjAy0qtl41bWWLqfADC80lIHJPYMWFoX/QsDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724699572; x=1725304372;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mnb6zYJ54fx22cuDC27883ytXeWKR6BtVeg16VP3ZcY=;
        b=S7i2AKZckyUMFdiPjNSBo6UYWTlGbML2q/pijvSiY8B3FlFPrBM3TjO4INIInNuh+g
         IcOtDWECFvu3sS6aDft3tjAmDbKQMVGWDhHKFN7exlGkCa8VzX7Myf5byqDdOlHcX80t
         LJP07/hjYBEghwXH98gLrGXWOPwQRUQuWws218CuZbOfn5ukqw+lgjQbZgwCW+nmWsBF
         dPwwXDvNjDdUInKsVGLTIQIS/gQUlWfSxjidjOjcg+iRsBMVy+gjva8YfZJ686muUAYB
         fDTSMjEylQR24L7o1HMjUKg+vlB0AVaB4dk618yTcXGNJVpsaJUrLOtrX98S5k4oUN8A
         pcVg==
X-Forwarded-Encrypted: i=1; AJvYcCVUqf34EaptB8tEnYaI8LY0udvJl0IbAxM/OOHsD67N78wKBropIhUxBZgMIHa1knzqshUh7ooTX7ymoIE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlc6Q0NeBRS2ghTI5k2f/xzsMZZtk8aPdLyRIft3KltgvJIVYb
	FV0/pYY/h8Ap9Zz47CJvklgSvqB0c1XvHL+UzlsHw3Che4a9HgKcNIrE6bQqpDc0cNRCH2HpbNI
	hZjHSsyag87+IQF7YSKlNSU89m8e66+ud11TYvg==
X-Google-Smtp-Source: AGHT+IGcz/kL7YCWV8ANb6vSB+u/NezOQdfZ0aDRNCl/94cnJqHv66LSwxNl0PlziLNZvLCEpJpKCF0l1e69GaSVMGE=
X-Received: by 2002:a05:690c:ec8:b0:631:78a1:baf with SMTP id
 00721157ae682-6c624fb6b9emr123189377b3.6.1724699571754; Mon, 26 Aug 2024
 12:12:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826130612.2641750-1-yangyun50@huawei.com>
In-Reply-To: <20240826130612.2641750-1-yangyun50@huawei.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 26 Aug 2024 21:12:39 +0200
Message-ID: <CAJfpegt_P=Dj-CXnbZYK+XZW8ZwNH0_Str30q9vub0o00UMuWQ@mail.gmail.com>
Subject: Re: [PATCH] fuse: remove useless IOCB_DIRECT in fuse_direct_read/write_iter
To: yangyun <yangyun50@huawei.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lixiaokeng@huawei.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 26 Aug 2024 at 15:07, yangyun <yangyun50@huawei.com> wrote:
>
> Commit 23c94e1cdcbf ("fuse: Switch to using async direct IO
> for FOPEN_DIRECT_IO") gave the async direct IO code path in the
> fuse_direct_read_iter() and fuse_direct_write_iter(). But since
> these two functions are only called under FOPEN_DIRECT_IO is set,
> it seems that we can also use the async direct IO even the flag
> IOCB_DIRECT is not set to enjoy the async direct IO method. Also
> move the definition of fuse_io_priv to where it is used in fuse_
> direct_write_iter.

I'm interested in the motivation for this patch.

There's a minor risk of regressions when introducing such a behavior
change, so there should also be a strong supporting argument, which
seems to be missing in this case.

Thanks,
Miklos


Return-Path: <linux-kernel+bounces-413412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB859D18C1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 20:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2CEE28103A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 19:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3AE1E0DF0;
	Mon, 18 Nov 2024 19:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eiSWAoFt"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4212C1E1312
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 19:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731957411; cv=none; b=L5pYtv7cbPY6m2APJbRaO4XWnUy+/PwOxIXN97XytWAPpsHwa9aF1/OSketfJvJeQstypppTjGdRMZAzWYu5EszHxah4oleuETfAcrSGzoUL+Xeh9l2ywsx7lwI+lOccv6P+aR2qFk9ucCfcKvMnwfc5g68JHFWLrDf7ZeB8aLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731957411; c=relaxed/simple;
	bh=veC1fdgseWNR+cmBB9o9SCfRRJVqnLiW6u43RiBCvLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CSAnb4kzzpkAbHvw0G8rVc1qHj4ZNa44lrwSOyMsvs74F2RXtUob37lerUyX1P4WiGoiMHfR17zqZ+I8VwzjP4kDl+zWq0mtfzzluAnJZzDv5hwQc0A4XQQF9jH1W3c21H805Xf0NKr2OKisj3dyFXi6U2uWGunQmxS/O+hTlos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eiSWAoFt; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53da22c5863so4972700e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 11:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731957408; x=1732562208; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=veC1fdgseWNR+cmBB9o9SCfRRJVqnLiW6u43RiBCvLU=;
        b=eiSWAoFt9ucZPricVmqBkDtDfAiuchOGek/Q4e4gQ8Y1UOx76eYb3VxB6nCtthS4vD
         of0TUEA84UcUVX6UOEmrc3BK62PoLrnwE+gfHeswS3OmRfSOf+G1z/sWtYibkkWMTA0b
         euqAqBjOmdh936QyIXGcnBW8uWwnCbSMZPD5fpr/BvMI6i75P0MX10h+zJL8EiQUYP7L
         mOhGK+C1zbVkZxMXBPoR4M/347R/vOcwwhjpZiYKRcGxlCH0EOpFEGN/gKAz075wIgtk
         jDbdDqSqdUSb5dYU+s93yNA+mmQpXALhz+pgdNZJ6BXQTHmuYwAiuWjWLUu6mpEt/iML
         Xs/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731957408; x=1732562208;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=veC1fdgseWNR+cmBB9o9SCfRRJVqnLiW6u43RiBCvLU=;
        b=wd+iVfM6B5Mw+QaKwG6oL5wxqa58ZH4hMegWIEl+B8ncnxk3sCumkVto0mK5L9KD9k
         QrbJsks4LteZwFF3eNe5IkOujxblHovopI+vcmxYEQf2+28Dr1W2Ors4SGFtaPLNFsN6
         NhLYabrJGuSCakJkZ7DnxlCgjNfgWh2yhCbhCMSYgouurQLcMFRMed5p1FioUeA8SzpU
         arJDImoDxFfHyiHJpeZtyPld+IQpoj1dCsIVCgJOY3Lx7W4qawHD3UvFuUnwbZ1O7F2x
         8zgPsinN/cg/u60UUlKSP0eWal+ZC3zf2oIAclz8kgc3m9eV7VBluJ7T8kdAVtbo9MiD
         xawA==
X-Forwarded-Encrypted: i=1; AJvYcCVMIYE7a4zFW8X1EmXB4Ev+vjXnteVAjMmVqm/fNcb9bmW4s1AElKkUcYfbDuwoRypHTGgkCvy6fwg50V4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLklZn15ngn18lt8qgkZ7aLyXY1d4ZQkNJ2rnj2Zz9UonNG+RM
	Q93J4Zlx4tYHqrNbLnorSch5l5k4Hmh2V4nliOQb/WkZ+qy9Yw1FKf01d3XcQNpB/rxqFP4Zfl8
	7IUgWXD/DLXe2jLv16KCO3dtnQH8=
X-Google-Smtp-Source: AGHT+IGbxbbdjLTwXoGvwgMOYFBnc8nDZqdOaadXIrBnS6EV8P6ZQuNFfk78xjYzi5h7kEggXFolAusQdjr8PAww+S8=
X-Received: by 2002:a05:6512:a8b:b0:537:a745:3e with SMTP id
 2adb3069b0e04-53dab3b05d0mr5821549e87.45.1731957408065; Mon, 18 Nov 2024
 11:16:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241116063613.15120-1-advaitdhamorikar@gmail.com> <883923.1731943099@warthog.procyon.org.uk>
In-Reply-To: <883923.1731943099@warthog.procyon.org.uk>
From: Advait Dhamorikar <advaitdhamorikar@gmail.com>
Date: Tue, 19 Nov 2024 00:46:36 +0530
Message-ID: <CAJ7bepJOjS0P88fiESvJAaoukFoqa619r3+Twka7z2osz1xTkw@mail.gmail.com>
Subject: Re: [PATCH-next] afs: Remove logically dead code
To: David Howells <dhowells@redhat.com>
Cc: Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello David,

> A better solution, I think, is to check the result of iterate_folioq(),
> invalidating the dir and returning -ESTALE if 0 and if the iterator count is
> not 0.

Thanks for the insights and the feedback, however it looks like this patch
is no longer relevant as there have been significant changes to the
file since then.

Best regards,
Advait


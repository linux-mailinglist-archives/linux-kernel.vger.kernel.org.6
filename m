Return-Path: <linux-kernel+bounces-262792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDA493CCCB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 04:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76F6E1C21754
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 02:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F891C69C;
	Fri, 26 Jul 2024 02:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3yzOtQY"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D178D19470
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 02:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721962476; cv=none; b=JBvNkGiatOwb1ZzJBxhHi+RYZc4+uXlCCZYS0/oy6UDfVDoTyhonUEfBrJ82NAjnmwlGgVUivaBr+JDqDIwxpIkhljwNciX227KCxyRwitHutb8B+GxnpyfAQfiO/tyoQs70VlaHa6DXVnphwHxf+uOUTEHCfgeEsa1cTgbRCkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721962476; c=relaxed/simple;
	bh=vMWEPcOUyRtngX8M6Mrk7Ot3BrsooySnXeJ6tKMXbgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CItpDTzOOi3eYJs+dbXbLrKVAqomAhF8yfa5mBECbGvcI5jYr3HXkePjM+ZyOZbfjOxDosvscyolvqisi81rFGDLB5arONFJ0SN+X10Rnl9YFJ91JPSs+DzO3xuF4iuewXO/ANwpxBYYuaF+ShlHjAQ652Tlqn2UHCy5qnh+zv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B3yzOtQY; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6b79c969329so1130056d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 19:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721962473; x=1722567273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vMWEPcOUyRtngX8M6Mrk7Ot3BrsooySnXeJ6tKMXbgM=;
        b=B3yzOtQY63MF8JoED0niIDz9TT3H1TfbhmB5NrYQP/Co2+Je9xF6rIzAAiDm/aF0FC
         fr1YnAztR70UWDGLUJ9M2XTRG7UfcNZhqBDi8Pt6fLa1nLlH/E0LKI5azOCjB8pCcMrR
         poelfoewNg5Ns2anklcRb+HRPqiXSvrr49K0c/oUEw4k7wjmzM9KeAaZbpjrrM6gVu0i
         fLOxT3IzYOyZ02RwmRnxT+KYr6gmDmFJI4lc9pRzPNoe3zqy/tB5XNcNmTS3XLrf+W+V
         AfU0v4MH90LOD0MT/KS6BH5RNJt0sfDOouquzq0O1pIPb9ytOMVnc76CEmiGKH1A9DGh
         R03w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721962473; x=1722567273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vMWEPcOUyRtngX8M6Mrk7Ot3BrsooySnXeJ6tKMXbgM=;
        b=LL56BjHtKsmP1eYn6oNB8c57zGNznYmWeM22G2LCHborAFP6Venxs0We44EvHptLMi
         HuPYW+37FtZaY4uWwvNi4sEIwU42tYQ07TqgdCvfAiInHtwW2oEMW3csvQte00pnr+zv
         f+Vh9K2JiCE8dUzeA0jB13uq3Sqj0mz6mze1tUrRT9wSCK+ktlanvWtL4zyBXkFKLCcC
         GjUyQ//mX8IuI6CooKrsDL7h5k8Ba1rlgn73Lu7rcEia2pE0QLprKRRYd/LrwkoXP54n
         Z9YYAVvmVq6U5Ryx5NPNzz+pTB2iMKesFLQTH9BV2qS2ZgawY/M6zHYmFlYXVwbm56+A
         C8MA==
X-Forwarded-Encrypted: i=1; AJvYcCX5+MDj70KO9zZ27bzV8M1iQcmD60zLc/tua6/S2v655xCXyR39DcM6aPHrjKMRzuLdRO98rnky7kcJYoJS7E9EO9bPWBNwRUDK6BVT
X-Gm-Message-State: AOJu0YyFy8vkuAE/DZYGycCwU6oBquRmNbGrWqC589Qk/CH+a0pz8t0c
	ulLII+CrPzhqOodGy/v0ibAqqHGBL2J6mTn58jesaERNRPMf79X/0nObVYPejncmk2FCzppCDNv
	CZVz42ZoidCWIg6bTSoMq/uQ6aZY=
X-Google-Smtp-Source: AGHT+IGOQG6kEeEk4W6pWxgMURol6Xanle3nUcYpoZucv3qedwwOmvakuhCva0EZ6ZuOdupHajHH7jrim00j9Kyy9wU=
X-Received: by 2002:a05:6214:2263:b0:6b5:e9d6:1ce2 with SMTP id
 6a1803df08f44-6bb408597c7mr49022356d6.27.1721962473518; Thu, 25 Jul 2024
 19:54:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725232813.2260665-1-nphamcs@gmail.com>
In-Reply-To: <20240725232813.2260665-1-nphamcs@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 25 Jul 2024 19:54:18 -0700
Message-ID: <CAKEwX=NURfoLBrnYtsW08+bUHRb8FpBLoizt=QEEkuxRhPjGBg@mail.gmail.com>
Subject: Re: [PATCH 0/2] improving dynamic zswap shrinker protection scheme
To: akpm@linux-foundation.org
Cc: hannes@cmpxchg.org, yosryahmed@google.com, linux-mm@kvack.org, 
	kernel-team@meta.com, linux-kernel@vger.kernel.org, flintglass@gmail.com, 
	Shakeel Butt <shakeel.butt@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 4:28=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote=
:

My bad, I messed up the cc-ing. I missed Chengming, and used Shakeel's
Google email :)

Rectifying this now...


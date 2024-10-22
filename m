Return-Path: <linux-kernel+bounces-376207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF8D9AA197
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 14:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44AD01F22C0C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 12:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7646D19CC3F;
	Tue, 22 Oct 2024 12:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="CcQSeACI"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FBB199246
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 12:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729598422; cv=none; b=aPjhFD6HoO+YJUKP97nXI/Pvk0Z2mmn34E4axz4Pp4s4MFaH3evj3aaayv8rj1tShfx4T9eE08787OJsIf9lFWLKY985t7r1tZVWzPS8S6LS3Jj7D/ZnvHJxbNjKsDc6k8iuhMsNfYFuZQCjwvctivXltUkvnCvUAPfpyn8HAfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729598422; c=relaxed/simple;
	bh=DiffitXSu3q4aybGs9Cn1s6e2cnctKUCP5vyccxptgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lTuzd3tjM75qiKNYKOgWyEwrbZOOdkk0nOUafydU/2HF/BbqZxq0lcSmOASQN7+XsRsAWEFtehvJjLk7JUKKvbd8wd/k9fRSyk02/udPC2U4ztUcLagzG05ohs56vK7vNftBa6zdq82k4ZOgORE0w1+PBqqeC0joeD38VFlMwTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=CcQSeACI; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-460d2571033so17340221cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 05:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1729598419; x=1730203219; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DiffitXSu3q4aybGs9Cn1s6e2cnctKUCP5vyccxptgM=;
        b=CcQSeACILxSmY79+JEX468p/D3eS0laJwggXR1Vx54t6XrHvWwYH2/1TU6iRFb4sf6
         e9U+dPAS1dmCfQ2AjZfIE4oQUshDCh1EFYYKtJAyA1xIR/ElZ2OODsVBMEE4J1n2q7tj
         fIiGqEhi/KRIgNTaHTtN/ziEbZ3O5FkmyMedk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729598419; x=1730203219;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DiffitXSu3q4aybGs9Cn1s6e2cnctKUCP5vyccxptgM=;
        b=Q6ctHzJeAysKSBi515cNtKtgBIoPc6/KqZjAn62br+KVFGlWxVGWblXblj3E2NJxjZ
         ETkeROaGes2OlyyMw/OOBb1vQug8iG6oxUBGUaSlWjxW41xxRq+oRUwRNsg1XYsNJpAI
         lGtGm4qHM52I9mWrsZeZPc3rP+YYAqNkzFLL+OnCDQ0BQV6x6u3QvRwzWV3JqgX3VldZ
         hRgXFFq6hBccTdK50GOY6wZ0SlphwMFBopcKJVF4qocwVPolDx+KcUUjpVf/Nt7RuYCm
         zhVIoymQoJOuvihj7Wx5lqtSQ6X8Oa9SMhwpZJc6lqLBTVQfCbnQl0HTZ1DdOZB9ZPpU
         cLFg==
X-Forwarded-Encrypted: i=1; AJvYcCUQCFzzGrsBymzM/3NfPcRPzlM298LJVEzPiJFmun7NpThnwdMiVw0YieFEK713H9L+Wn0NAOZyPo32OH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoX6jjCKdbn6nHmT0d74N5sXaPKpLnTtfDIHo5Lox/5N+6CJgb
	hp/7O4vRI4ceoDlWyaEi+cIKe12UoTNwnW4s2Fq5YvrZsU+kIezooZq75em6djwOc6k6Y0WiqsW
	cIs0NJff+hv9aLX7vpu6InaxqsrXPSb3qZUOpTQ==
X-Google-Smtp-Source: AGHT+IG9IY5lCN/KKIwSNtjspiRh+GuoZG7tuF/osqrqiSNPMuUSVe/lzomYwLUtFhE58ZQmncRkLGo6BJUnoFdmm5o=
X-Received: by 2002:a05:622a:5499:b0:458:4a68:7d15 with SMTP id
 d75a77b69052e-460aee2c490mr176091071cf.44.1729598419272; Tue, 22 Oct 2024
 05:00:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021125955.2443353-1-houtao@huaweicloud.com>
In-Reply-To: <20241021125955.2443353-1-houtao@huaweicloud.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 22 Oct 2024 14:00:08 +0200
Message-ID: <CAJfpegv6KG92O875p0+5rm1bMb=pb8eyorhkpg4Xroo+BGpW0w@mail.gmail.com>
Subject: Re: [PATCH] fuse: zero folio correctly in fuse_notify_store()
To: Hou Tao <houtao@huaweicloud.com>
Cc: linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	linux-kernel@vger.kernel.org, houtao1@huawei.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 21 Oct 2024 at 14:47, Hou Tao <houtao@huaweicloud.com> wrote:
>
> From: Hou Tao <houtao1@huawei.com>
>
> The third argument of folio_zero_range() should be the length to be
> zeroed, not the total length. Fix it by using folio_zero_segment()
> instead in fuse_notify_store().

Thanks, folded into the original patch and pushed to #for-next.

Miklos


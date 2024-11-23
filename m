Return-Path: <linux-kernel+bounces-418946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A456F9D67A8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 06:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08F35B21E34
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 05:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76384169AE6;
	Sat, 23 Nov 2024 05:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MD5SX6iK"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30ACC81AC8
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 05:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732339400; cv=none; b=TlwzTIAdDf/x2aS/2d8VAmFs7a250/eIubEE1P+0LZBpcyWnRtG8nIM1nHkABFl2i3udCzNTMpLNwtJFJGer/EjhQoxtO8/fX4pWIZjki6m6TN47kpDwtjW7kY7MU07IOtgzBZ0/+cnosfWBz+9CKWaZ2rclWWPrf8iwwVwOSHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732339400; c=relaxed/simple;
	bh=rU0rvkhWpzGBrA+g0K/jMXCk03/3N95dD4xq/uowYCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gQf9m+AfVi3VxZGryezOHsuCxdL5DfVLDzHYeQaIm2efyOMNaZNy4ozcWkfmDNqyKYhf2khcZ7oInyMJOo7c6/jwEr6yeskgyFi19bF141tRfSX4eKwBLOUs4kos37e2Y4PRgxpwCNOjjWhu6GEDEn4IQA5en/85kWVHXP1evW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MD5SX6iK; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5cfa1ec3b94so3253080a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 21:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732339397; x=1732944197; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VSjGp3IroYTG1NE8bIcBd1OeNZO7AKZ38NmgfyznURE=;
        b=MD5SX6iKfEFaQEYdXcIOc9vFcj8niaKWWt9USx7qCwl9vHYiqRVpaWrYwI0l08jxfT
         mBuxbXZAL46Mo+RmcGVr+MjgB0Ecol3p6wMAPJ+DWtdgt2MRkVlcvPmLM9O3Wi+/rukL
         MzTIZFbKENFVRQymaVg0d/T4rr7alC7udUnNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732339397; x=1732944197;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VSjGp3IroYTG1NE8bIcBd1OeNZO7AKZ38NmgfyznURE=;
        b=picciE2oy3Ghg0mgNzc717NWMtvIjOPXplqTCRBK9T8aZoTq+vQKJ6SQfO74M2bZiF
         gYoNsI5qmc1OXFESNhQB2DDw1/kTFrPS/0p3mhszhgB//loVUZW6xwPEGYUpaIG6qAvW
         w6/GCOR1BADuqP95k/KqY+B7cRSWLRzxqjnuY1TwF6/HF7ADHtU2p6gxPxbzdkUQrkg9
         wVdvnzFYITu9LSAt1jWrkUOe8XmDKIjDPR9kcFk2HClisNJWr2CmV0jnOy8kv7sHjJ6L
         F6b+9l1eAM0iqkSEvJ9apzD77YiBA/YJ2VHX2yZHmC6RGck+s7dC3o/pY0NsSyDRrB+Z
         1EwA==
X-Forwarded-Encrypted: i=1; AJvYcCXExcUBOtFIq91/5/zR3GGq8OBx01NuIIA9WLPz0awpKJLk/PsZC/2LTATerfQt7xwLtJrkbG3P+JLxpFE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn1HSKNM4gWni2jbC/itVLznENOooNEQTNh0a6nPt7UgJmKxNT
	vAM5/XZMbeiI71+mBaKA5vqKpOVk+bA0A6FE+MGFQ902X5PM0A6oKnRdfuKw9kaLj/DzKEsHr0a
	3OIlWjQ==
X-Gm-Gg: ASbGncuqs62q8CZjy+g2y2AjgGLtbR9D9LTP+59Jd1a+CIeFHH3QQdUh6X14urbEhEV
	Taihx9N85cG05oSXSiAkOLPjjX/6nm75Cz3LrpEPwI7xr1D6fCmT3Q1n8PWNXhgrHVjA5Ip66JC
	mRHdqIezafKAZqvLvV+ax0f8BlDONXwnn/opOCv3X4KTTay2qmdgEuTTJSekNOzU4kOHoCbCfIs
	NN5P8TxI30U88sWQrImFrwxek1rEx9lnnpdYWngfIOn+BE3EydYrc1cgafuJ2nZ93Fh7TrXlvHX
	SeAJeBwK/aBzA8p9mPiKV9Bb
X-Google-Smtp-Source: AGHT+IF8BAnVTb3hKIdHX4Jww+iA83hiktBh5FfVYHM2dKtSYMqyBoslW3TD1I3DiB0P5b/1i4XTAw==
X-Received: by 2002:a17:906:3099:b0:aa4:9e02:66f6 with SMTP id a640c23a62f3a-aa509907639mr418394466b.2.1732339397209;
        Fri, 22 Nov 2024 21:23:17 -0800 (PST)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa531d6f0a6sm47522066b.196.2024.11.22.21.23.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 21:23:15 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aa503cced42so219946466b.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 21:23:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXDpzffiW2A6OkdnVEXQVgsK21g+ezN9M9pbz+93tueO+9KbT+XPOmusmbmuOGeuIdMYInn5x5BULsv+Vg=@vger.kernel.org
X-Received: by 2002:a17:907:77d6:b0:aa5:31bb:2d with SMTP id
 a640c23a62f3a-aa531bb011emr102010766b.20.1732339394655; Fri, 22 Nov 2024
 21:23:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122095746.198762-1-amir73il@gmail.com> <CAHk-=wg_Hbtk1oeghodpDMc5Pq24x=aaihBHedfubyCXbntEMw@mail.gmail.com>
In-Reply-To: <CAHk-=wg_Hbtk1oeghodpDMc5Pq24x=aaihBHedfubyCXbntEMw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 22 Nov 2024 21:22:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=whRp-s-GNZNdtCe8dOhpM0zihk4wUAXK2RsCf69fSW99Q@mail.gmail.com>
Message-ID: <CAHk-=whRp-s-GNZNdtCe8dOhpM0zihk4wUAXK2RsCf69fSW99Q@mail.gmail.com>
Subject: Re: [GIT PULL] overlayfs updates for 6.13
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 22 Nov 2024 at 21:21, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So I don't actively hate this, but I do wonder if this shouldn't have
> been done differently.

Just to clarify: because I understand *why* you wanted this, and
because I don't hate it with a passion, I have pulled your changes.

But I really think we could and should do better. Please?

               Linus


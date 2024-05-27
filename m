Return-Path: <linux-kernel+bounces-190754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF9A8D022E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 735A41F26C61
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3591B15EFB8;
	Mon, 27 May 2024 13:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="CEWDhMIg"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917AE1640B
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 13:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716817872; cv=none; b=kiXGjDq3Qp682BOsHKU+XbooA2YqYvoLDwMsK5vbjhPOOGSMk7Un8C4V1QV3wbI19MV/oK4CzUQ7IThPx/JzbfSLh2MtwSsoKamLRLPtmz7YZpuIZUcDkGIYDW5vsY9ZlmxIg6S8yl6cSzc/2vWNv6AwtOtGQWvDRFrWaQP/AaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716817872; c=relaxed/simple;
	bh=uuQY43wa+0cys4WzKZsdo95EDIza7dv83nymBpPfuio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dSTo/abiVlsetYKrU7jqRlOAx4HvhakhHoAxVjjW+mxq5Sqsb3zfukHtThvUbwJJmGkMp9C2Z0pg2fr+epPKDWUl9Gi6+pMafnVwm9iTT1txmGUWe3k3Oyg2g0WMmnsMDAiXPQUXgsqmh3hGnF3sCiuE3a4mSXAuc8BGzPrwX8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=CEWDhMIg; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a6267778b3aso225073166b.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 06:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1716817869; x=1717422669; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uuQY43wa+0cys4WzKZsdo95EDIza7dv83nymBpPfuio=;
        b=CEWDhMIgwS6jcTyM9CnO7Rs5RJSfU/Ovrj3b06MqDJ6R0YIYvhzNBppzLFJqGSdNmy
         XiTjn+ECfLvvID5/oJgG0etMRFTl4BEZEDxCCZ8SNhtcOx3apaD8OEhdO5DZaGW065Do
         cZdNLeGeLioeciz/B5oH3VdXomvPXOPafXkds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716817869; x=1717422669;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uuQY43wa+0cys4WzKZsdo95EDIza7dv83nymBpPfuio=;
        b=H0fEWyuzVYHKdDPI5bSYrLyi/2EtbbCw36TuJADeGnAVIVDKIkL1A5/bKxkWqRoq/x
         Y+bEMcn60rKiFqp2COWUcR4rGabhF7lOF+MX64g7K7tiBdAPqVQVcoAVGcZmk08j43Wv
         w7udt8zG5Xb1f6bGd5qp+LgJKQdKE96nyNIucGQYrOugI2rATbvq3BqkUFYP5alit3Gy
         tzaQvy2tIEDdzH136KS6PRPvqOPZbBj5ibFGqSDMEgUZMddwfI+2iWu2/uIXc853C0jK
         ZBhmLN0Sbz6Ut/Zrox3JrKAS4xWQemd71nasowQ4Y/qrr5B2BMLiM9hnbQdw12JsaFxv
         pGnA==
X-Forwarded-Encrypted: i=1; AJvYcCUQJet1gyew8P+4uJPcSv+8rdrZ8F1OzIGxRaNNlvafaZ6vM3L6tyQtyTip9XYhUvN/CY2UTBhl7KPgxJ2vdjus1+UrhBYUfLwHjd1y
X-Gm-Message-State: AOJu0YzdS57wHh0T04JYPRNuFG94kRoZKQjqVn3fz3Z0qYuvSBqP/cZr
	b8T29uI8Zw98Q2q3DryErfytnus0fL7/3mbBT50xbCzXIJyd9APBmQqSrUbHzbPdHhoXLkcLfgS
	P6cW+O3099LRtSkqSHfkRaO9w+gKYacHqB0ESMQ==
X-Google-Smtp-Source: AGHT+IE+776/I97VJo1iquiMi/Yw2Zf4q5ChRdOsvC6Wn8oeSttS7ENd+orAmozSW0Y0YeHPwc8Ri+zGLINvPPdC46g=
X-Received: by 2002:a17:906:5a70:b0:a5a:1562:5187 with SMTP id
 a640c23a62f3a-a626512942fmr636424766b.55.1716817868894; Mon, 27 May 2024
 06:51:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000f6865106191c3e58@google.com>
In-Reply-To: <000000000000f6865106191c3e58@google.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 27 May 2024 15:50:57 +0200
Message-ID: <CAJfpeguD5jSUd=fLaAGzuYU-01cKjSij6UbQWy72LDpqK1KQfw@mail.gmail.com>
Subject: Re: [syzbot] [btrfs?] [overlayfs?] possible deadlock in ovl_copy_up_flags
To: syzbot <syzbot+85e58cdf5b3136471d4b@syzkaller.appspotmail.com>
Cc: amir73il@gmail.com, brauner@kernel.org, clm@fb.com, dsterba@suse.com, 
	jack@suse.cz, josef@toxicpanda.com, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, mszeredi@redhat.com, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git
 f74ee925761ead1a07a5e42e1cb1f2d59ab75b8c


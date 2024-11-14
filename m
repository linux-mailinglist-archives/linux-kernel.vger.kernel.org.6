Return-Path: <linux-kernel+bounces-409354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9503B9C8B9D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 14:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A134284791
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 13:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888C11FAEFA;
	Thu, 14 Nov 2024 13:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="qRx+3pYM"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA4218C32C
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 13:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731590180; cv=none; b=DXndqiUoTFowB1M02SceqYdZHFjSJpDTiYcDdKSR2FI+a/B482VA/s4zN6x7mUE+Kso7u7dpqGWaqfpgcxfsfXinWBOao3L33Q57XrcGY4Uwy8J/knwGLKlbRpDT+5wwc6Ic8WWzGpM/JTdJ/mdrHaTZ7Weum4oJhYX81xvG0pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731590180; c=relaxed/simple;
	bh=eH26dx8KLUCKW3OLtuzDQy6K2ox77weOoauZXDs0gIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ulJVEUzamsb/Jv9LWcOB0xDADJuALSi3n9mBNR6QBTUQEUUfA49ONhvvd2AYqn0Do2QVhJ2PiUZIxssoPSaunxAn/SwKEk4YNXJR18SFVXtAu36xQpg/JbH/8j1kahysZo7kkok9vTxoJM2vjse75tMMZqxAOAsBC1BcG2KMav8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=qRx+3pYM; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5ebc27fdc30so235416eaf.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 05:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1731590177; x=1732194977; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eH26dx8KLUCKW3OLtuzDQy6K2ox77weOoauZXDs0gIA=;
        b=qRx+3pYMb/6Nz3ApTXHSG2pqPnnr+tnjuTbmAW99f61xAj8YZ5T6f/f1Z/LLb2G5VE
         oWe+V5Gp1j1dBEDl0A2Z3NQtwQCE3Nf7kli9tzCE1WhYtFOLLn0tcgXBrbTXMJvJqwdI
         hwXG63tdk845Zus1oIgh7AqDV9odOMswGYoNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731590177; x=1732194977;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eH26dx8KLUCKW3OLtuzDQy6K2ox77weOoauZXDs0gIA=;
        b=K0bo09Oz1cG61LjCXQZHcByPh4E9MsfEcDsBS1AkvINXQibBzuhp1agcgIoOjtgzuL
         4pt5w8Gf3EpVlkyOIU15AkBBPu+8Rif+LF7md6H032e+egCkAEr/230buGzR5CYY24Vd
         jhJZnS+IHWG+BAnInlYWscOmocwiFdYPggCILVmGwOhz9uJ4EewdnN1v4Ir/J2O7KV5n
         82SR++LHiQprjI5pFvTHzxqOnROB/XRGxqV3iKeG25mLGyj36M2nHqQCgT8ShBYHMPyr
         WSmTVbjVB1BVlKVY41xUgiudSNytaaGXfHAmyndhyW5m7vUohlDLZlMgs/GnFBTkNXtd
         1C1A==
X-Forwarded-Encrypted: i=1; AJvYcCVeLOKGthtXfsasfLT3HJlhju9pioXv30+9LXJjVkgZtIGwXKFYU16EBahjobZxvTcIIt4bmAgg3OCy9MU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAREshDwr8y6NW/1lW1xXEmhuC6fATbVX0ZyYndhidcAhNAzWQ
	D73jMNXe7/CxHvFC3FAjXxNNuPoBW9fH15vr0KtwjovdIpbmAq+eUSKnjLpfbZ1dQViUCZU3L+z
	9jPMhXfDWrN4/mgty8f5Gj+vmjykHwzWLA3PZYQ==
X-Google-Smtp-Source: AGHT+IGOh7o2rK8Z7Xq3ismcY3/JzUtU+Mh/52llN668SNCDj3rlUfRC5K20zJzmxPpR4TWcURWseOJKG15ZWHkwsKc=
X-Received: by 2002:a05:6358:9791:b0:1c3:2411:588f with SMTP id
 e5c5f4694b2df-1c641ea72e5mr1261388955d.9.1731590177471; Thu, 14 Nov 2024
 05:16:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111-statmount-v4-0-2eaf35d07a80@kernel.org>
 <20241112-antiseptisch-kinowelt-6634948a413e@brauner> <hss5w5in3wj3af3o2x3v3zfaj47gx6w7faeeuvnxwx2uieu3xu@zqqllubl6m4i>
 <63f3aa4b3d69b33f1193f4740f655ce6dae06870.camel@kernel.org>
 <20241114-umzog-garage-b1c1bb8b80f2@brauner> <3e6454f8a6b9176e9e1f98523be35f8eb6457eba.camel@kernel.org>
In-Reply-To: <3e6454f8a6b9176e9e1f98523be35f8eb6457eba.camel@kernel.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 14 Nov 2024 14:16:05 +0100
Message-ID: <CAJfpegtZ6hiars5+JHCr6TEj=TgFFpFbk_TVM_b=YNpbLG0=ig@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] fs: allow statmount to fetch the fs_subtype and sb_source
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Karel Zak <kzak@redhat.com>, Ian Kent <raven@themaw.net>, 
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Nov 2024 at 13:29, Jeff Layton <jlayton@kernel.org> wrote:

> Ordinarily, I might agree, but we're now growing a new mount option
> field that has them separated by NULs. Will we need two extra fields
> for this? One comma-separated, and one NUL separated?
>
> /proc/#/mountinfo and mounts prepend these to the output of
> ->show_options, so the simple solution would be to just prepend those
> there instead of adding a new field. FWIW, only SELinux has any extra
> mount options to show here.

Compromise: tack them onto the end of the comma separated list, but
add a new field for the nul separated security options.

I think this would be logical, since the comma separated list is more
useful for having a /proc/$$/mountinfo compatible string than for
actually interpreting what's in there.

Thanks,
Miklos


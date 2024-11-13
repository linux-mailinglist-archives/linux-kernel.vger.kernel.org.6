Return-Path: <linux-kernel+bounces-407633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6B49C7045
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 14:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82B461F2847B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 13:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053011EF955;
	Wed, 13 Nov 2024 13:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="NKEIsJGa"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478B21DF974
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 13:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731503305; cv=none; b=fVjXZ9W30JAikxqr2T/waGpvo9JZGe0DI46dQ+E+1GidT9vkvHdaFv6z7cgXqbAgsXwP3PxMMFe/diD8ugFply0t87/2cZRI9nAszRIuvxKU5K5s8tDxVaKrCswT8/8sUE4rl71/rgwH9NE+9FzHdUE0slxb8/9AacVzqIa/g7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731503305; c=relaxed/simple;
	bh=LdVXmAUs2lzzBBui6LjWMsR9FRw+OK78+eYWZkrUVr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bgeYXSHG7BmuVQHS/ZeG0yrnH0KlA2qAqWoj0jMhXj3qm6GGgOTQkKbiliBYz68Crk4wJcNd56KxBBy2pq7vE6AkfPiFCKgSYxt6ZxeVtB+UtDcDDIsjJR5eTb4M+Vd4OYH2Q1/1fh+QqmfvCIOxUQXGqgKk4AvagAhBAcBePwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=NKEIsJGa; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-460dce6fff9so48397971cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 05:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1731503302; x=1732108102; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dxAolXJw8q+c5E6fHqK6JawKOgYA0bI9+BSxyIdr10o=;
        b=NKEIsJGafoLQSNz1qX/H5C/H43ryLkEYQQTJ+1PwwQfy/Ucvf19+hTn/IrwCv95gev
         7CXpUSjGZn3c/crHpLqW9nnYxVMxekX3XWLDNla6OqRcSO3r2+8/BdXQozHYVEt3gkdy
         ymdDXSMBNPom19kvFupgAtKFMfk2muvnvklug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731503302; x=1732108102;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dxAolXJw8q+c5E6fHqK6JawKOgYA0bI9+BSxyIdr10o=;
        b=vWl7yTICl/xDVC80sG38JP+k9lpUBMFm6UT8lR0eMsLfqVXvOrvWbiYIaTtKWzrB/G
         0Xo6v24WQ6r5HKy7rccpqg5+19p045HZQnqi+niJsBCD0fqWh47SFgL8tJdCRnJr0cGF
         RQ8OmtJElqk5PSGeXIziI82/GzHp+Bi92i2lyb68800aZqzozDAfRNU4TAEJbkNbTD1C
         RTFAlvaTswQ/u8NJdvvMUebRRrxJJcSDIT0X9Ad0/v98mfOvY336by6Njon8ZsaxQwbo
         OYWgvdv82D19VQobphtjNixb5DVr1PKj25wiYoxyb9sgeCJjTRna/kCQ2Sefy+lDxTvB
         o2xQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfXGYGk6q4tGPSupg4arSJ61JxMH8mD5TojEy4iyx8JqQ2yI8CBLNO8enFyTr/cJ0rxghn/6qSzVMRamA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaDu1LsblL87DOb3j/CdEYdOqNspcSD2fokqT46SczPhkE4m7U
	xdzVVCmglBNQnbxRMGAmHF1T61Ua8vnTOeTbtL23mjBrkzs7dH9pKJdy5S57a/Bh0ui2yFzzQlE
	bkGmd2xYH0i/RBCjGtOC64JyLdP/chYqFthuQCg==
X-Google-Smtp-Source: AGHT+IGxGwBdEhJMi0woe1ZeBiKfmzs+SyJfOiLoo8+xW2OznMbCBZfVwU+OpoikYOP0mugFQcXxs4AZ9ELzRFibQj4=
X-Received: by 2002:a05:622a:5199:b0:460:acda:1bb7 with SMTP id
 d75a77b69052e-463093ef9fcmr313523891cf.36.1731503302272; Wed, 13 Nov 2024
 05:08:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111-statmount-v4-0-2eaf35d07a80@kernel.org>
 <20241112-antiseptisch-kinowelt-6634948a413e@brauner> <hss5w5in3wj3af3o2x3v3zfaj47gx6w7faeeuvnxwx2uieu3xu@zqqllubl6m4i>
In-Reply-To: <hss5w5in3wj3af3o2x3v3zfaj47gx6w7faeeuvnxwx2uieu3xu@zqqllubl6m4i>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 13 Nov 2024 14:08:11 +0100
Message-ID: <CAJfpegvTEGABRfk0fAu4tv0qD9a2sAmFrmuDqzvdkR-JXGcdXg@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] fs: allow statmount to fetch the fs_subtype and sb_source
To: Karel Zak <kzak@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>, Ian Kent <raven@themaw.net>, 
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 Nov 2024 at 12:28, Karel Zak <kzak@redhat.com> wrote:

> Next on the wish list is a notification (a file descriptor that can be
> used in epoll) that returns a 64-bit ID when there is a change in the
> mount node. This will enable us to enhance systemd so that it does not
> have to read the entire mount table after every change.

IIRC Amir said he'd take this up (this was at LSFMM 2023).  I'm also
happy to take part in the design and implementation.

Thanks,
Miklos


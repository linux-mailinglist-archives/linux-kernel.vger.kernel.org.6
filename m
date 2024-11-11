Return-Path: <linux-kernel+bounces-404218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 042269C40F1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 15:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADDF9282986
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 14:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A17319D060;
	Mon, 11 Nov 2024 14:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="e4lRltPZ"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51E11E481
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 14:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731335475; cv=none; b=Hz079eFmk2VzMqIf2yZDHs80PkRkP/WXj5NAyRP65f38DCFK0DNVYDYFlAYpT4Y/sEWb9kSNKkGBCf0cup18wi0/Uiciu+AK9kfCfiidHxGDS1HVHA/0uZ4CC06FLXYH/Zs7mM8MX4b1CFrHq4aId+QMfvtssZvX5TeGYY9ZwWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731335475; c=relaxed/simple;
	bh=XG5CRUkTbt5WTQ85dK7AB2Vi2VrUURBKyYaPqbFSJsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rXBwg76Y53uFUYSxh2NTAQz/h1PNhIiTcVBh+8lsAR3xByFipWxEwu6n/bBZrPSyftYiwUkDpqwk9l0digKJx8oT5jkNBSnV0ix0fm3hZerM6TYLLub8iGXOS6fMofWjsA/0Y2A7XfxYJB1NzXTY86MzgugK65ZKSyuGnRZSfRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=e4lRltPZ; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-460b16d4534so26451801cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 06:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1731335473; x=1731940273; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bjQEvgWBp2B3femAyiEE2sDZdOd4LPyc39EnesXrraI=;
        b=e4lRltPZTRMcRopYCSZ5K4E5GjNBPRaQYkQeb5myivIgE6hPKRiWritJKsHWqUekba
         qRFfs3qLroyjcT7G5AA4PKkylisQUiqu3uQ9GvgRbl/wfQh+XY8Gytj5cAytC7bInR6S
         BpXM8/UjE+R1rrbM7ktRkO7nc9/p/JYoWYwwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731335473; x=1731940273;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bjQEvgWBp2B3femAyiEE2sDZdOd4LPyc39EnesXrraI=;
        b=F1ACwhdMQfYineZZmrzL91NaFfgDxqk5vCoybo7vvf/rU0wQpLasVNYhs4JvoP7Mom
         Suk4jAYYA6CwYGNvRrS8k7eY+hmijXT8MG0HcpJQiPQXMeClHZs3dCYxf6JH3e8Uaz8A
         5OKCBdFEfMW4x1BHjubJu5kC8PYME+NoJ5XRffKzzIyg0ebtQa8wFOzTjO0rRGgxVF5e
         uaTZ9qyM7V5CfKO91MGWRI2yVRc/4YLpfsJY2wZPk/SyRM1bP4gDFaXWMq0MEigDPrgI
         5/WqVHXXhvQntcXOpypvPH7vEPt371XjnG2sRClzOwoxdC+yQ3k6CWsctSp3CpKLsGC7
         tJGw==
X-Forwarded-Encrypted: i=1; AJvYcCXO0cZTMvtiiFQIKrVu6tn9N8Kg7sczYkr2x0cZJRVEqmEdGmthYVbFDVLWKPV+I0YTCI3EtZJlNl0cx04=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5odWuMPQkeVpXV10Ig5HqduRpxIm2mbMb/DkmdhxZHFHfbVc6
	zvwfYAcC1HDyy6L99t+DGJqa40+586BmU9Oy53iiQW/MFP+Li3NKRuwGKZopSRIXQsJTqHvJWSA
	o4gpiWiydlfDWTAJmv6b2GN/XlHWtQiszW3EnHA==
X-Google-Smtp-Source: AGHT+IFwjfVAdGvSWbVD01pjbiSg9CpPS5Fc1yt3FmFrR38tF8H5FoVF5ez+II/L5JrvR2ee4KQG3Qf9gFrr1WpImC4=
X-Received: by 2002:a05:622a:4e85:b0:45f:8ee:1859 with SMTP id
 d75a77b69052e-46309209d1cmr172053631cf.0.1731335472760; Mon, 11 Nov 2024
 06:31:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107-statmount-v3-0-da5b9744c121@kernel.org> <20241107-statmount-v3-2-da5b9744c121@kernel.org>
In-Reply-To: <20241107-statmount-v3-2-da5b9744c121@kernel.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 11 Nov 2024 15:31:02 +0100
Message-ID: <CAJfpegs9ntOf-nZchBgx3DnxY-gYzBM0atOBQuXQse-9pinLSQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] fs: add the ability for statmount() to report the mnt_devname
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Ian Kent <raven@themaw.net>, Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Nov 2024 at 22:00, Jeff Layton <jlayton@kernel.org> wrote:

> diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
> index 2e939dddf9cbabe574dafdb6cff9ad4cf9298a74..3de1b0231b639fb8ed739d65b5b5406021f74196 100644
> --- a/include/uapi/linux/mount.h
> +++ b/include/uapi/linux/mount.h
> @@ -174,7 +174,7 @@ struct statmount {
>         __u32 mnt_point;        /* [str] Mountpoint relative to current root */
>         __u64 mnt_ns_id;        /* ID of the mount namespace */
>         __u32 fs_subtype;       /* [str] Subtype of fs_type (if any) */
> -       __u32 __spare1[1];
> +       __u32 mnt_devname;      /* [str] Device string for the mount */

One more point:  this is called source in both the old mount(2) API
and in new the fsconfig(2) API, where it's handled just like a plain
option (i.e. "-osource=/dev/foo").

Also this is a sb property, not a mount property, so the naming is confusing.

So I'd call this "sb_source" for consistency.

Thanks,
Miklos


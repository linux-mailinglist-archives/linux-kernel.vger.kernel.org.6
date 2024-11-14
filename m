Return-Path: <linux-kernel+bounces-409359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C999C8BAA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 14:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AC6D282EED
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 13:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E301FAEE4;
	Thu, 14 Nov 2024 13:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="O+JLA/y/"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FD11F9EDA
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 13:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731590471; cv=none; b=qkmNKdV2l+i2nbrFLg93k1NfAZS7qjgABMbZ1dTw/judUvT1BFi4z1qLtOHvHU+aCI932DJ9VpElyHYmtA2ssP2d+AD8prqupMKdfOnXkFZ60ZGguARLL+6mHSOxa0OS9x0pEM7aVW8OsKAgntqPKNFTU21Ryxkkfm+AsjvJlXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731590471; c=relaxed/simple;
	bh=A786/WKYl8XPMPOFdqL11xIlC2GMhjjJaMsmbu3TsT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eQlb2s4wVF7+xAMDG0PoZfqzZp1UxFTd+WcZ8TFSrzY+cehR7B/i3fPf8fnCqfzXiM5MjGvH7Eng0RZG9PADLQej8eq2DNB8WwmR7iVrvVVvafqEHXZbSEv5/fDUv1op/ss3rsGzCru8gmfLRI2VSDE+9nx2T2Lk9Y+bRT3r0pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=O+JLA/y/; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-463575c6e51so5662241cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 05:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1731590469; x=1732195269; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VRfbnelZeJfrngVoF9cQMEJPOYnQHW9d2DowJs6V8LU=;
        b=O+JLA/y/7rvqOIncYm8X2dBe4uEN1yDyC9pQ2R7cvjXda/IentupLrNI5ec6+2hGxp
         QbOroLvyFx69zbMK6IbtTR8rr/lPQzJ1Ve6agnQeSyfXLdTdL9l3FWw6WB5Yzcp8JDvh
         KM8aiBIua7c0oxQ44+LyeF2MPezf8tVpWgLRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731590469; x=1732195269;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VRfbnelZeJfrngVoF9cQMEJPOYnQHW9d2DowJs6V8LU=;
        b=v0z8z6BpxVCa4FHtWxV0v3++cAZHIigTnetdL2QK0PnOqbqWVRM2Z/boaD0NNi/xwn
         rqUEgm0VOAsOZt4+CeNOvkhI3AImOedGPY4Zy6x9WRMhGycTYknmdk4OtkDKlYZSfGv8
         TWNSwA0Eh63qTTCkgzqGxHtrF6evkKVLCoS5cbvxwNaStyH+Dm2fcSZPD/C00BaAZZAj
         uN1PeGJX7/iWhdvF3ow8yWCDv8LsHzMTTSB8uyIc0anDamxfDvojz90H78GCxD32ftlx
         Gv3QoL7h9xwuvyutzCylllqJ2q7kd6TeCxjIBqxcyMDqSeP5QjhLvCu4eXhnCu7C0y3Y
         EU2A==
X-Forwarded-Encrypted: i=1; AJvYcCUCbxqMZqSn2biuhL1VZp1Q6tCRhuxctcy3cWxHv8/VxSqdvf6Zwv9PFHBCTbEwbhE/5oS4/lC/lxUm7Tk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDB/kLYXsyifEO1g6KBGRLAbuJmgnBTJ4AjTz52p7vwRRAAN3W
	ak1royig2aJqMfS91krcof4ktlmvWCWW59QXBppxGmtecF3h/vTiGRrDBNfDPsnZ5LJrUPVoMpX
	zw/ij3Sp2vJloqgjcpFV3akhl9CEgCr8JQAukTA==
X-Google-Smtp-Source: AGHT+IHov9rGqtzN5oWlMJTxAP3c0s3NW8iCKhJaT2L4/b4lmENmcMVKSJd8PArNdJ46UKbpr5wbhwLZZ1ZKzkomfLY=
X-Received: by 2002:a05:622a:5b0a:b0:462:c1c6:d8f5 with SMTP id
 d75a77b69052e-46356b2db0fmr45431741cf.8.1731590468993; Thu, 14 Nov 2024
 05:21:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111-statmount-v4-0-2eaf35d07a80@kernel.org>
 <20241112-antiseptisch-kinowelt-6634948a413e@brauner> <hss5w5in3wj3af3o2x3v3zfaj47gx6w7faeeuvnxwx2uieu3xu@zqqllubl6m4i>
 <63f3aa4b3d69b33f1193f4740f655ce6dae06870.camel@kernel.org>
 <20241113151848.hta3zax57z7lprxg@quack3> <83b4c065-8cb4-4851-a557-aa47b7d03b6f@themaw.net>
 <20241114115652.so2dkvhaahl2ygvl@quack3>
In-Reply-To: <20241114115652.so2dkvhaahl2ygvl@quack3>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 14 Nov 2024 14:20:58 +0100
Message-ID: <CAJfpegvDOPSJn1PeXRJqex6NRPUJtWfWvZnwCRD+E9dWVhWumw@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] fs: allow statmount to fetch the fs_subtype and sb_source
To: Jan Kara <jack@suse.cz>
Cc: Ian Kent <raven@themaw.net>, Jeff Layton <jlayton@kernel.org>, Karel Zak <kzak@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Nov 2024 at 12:56, Jan Kara <jack@suse.cz> wrote:

>   What I'm more worried about is that watching the whole system
> for new mounts is going to be somewhat cumbersome when all you can do is to
> watch new mounts attached under an existing mount / filesystem.

We don't even know if there's a use case for that.  I think it would
make sense to think about it when/if such a use case emerges.  The
inode notification interfaces went through that evolution too, no?

Thanks,
Miklos


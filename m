Return-Path: <linux-kernel+bounces-355737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B6899563A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 20:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D2CF1C24F3D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 18:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB8F212643;
	Tue,  8 Oct 2024 18:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XKhitnH8"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C981E0DA6
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 18:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728411137; cv=none; b=fNwX2PKT/T4qz6In3eANrzQewwmNoLbKdXJcTcMKALxprRnWKVZr+it4QPbhu1bxepd9Rf7djwYAqaLRCU6FIdSVk2S1uWH4zQ6lt+50LFTMwpjzMfu0PqxcTPwB5ORFBBBo8tzPPuAUWSa6OCBZkTbirzkEkvAdfzW/f+HLJm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728411137; c=relaxed/simple;
	bh=vhTuNa6pMB03W6hOrEtrcOG4oqbqI2buTXqpaiOtkBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tpQoX4yntvDQoaeRtedLQeRu7ERs+sQQOR5sqaNof2JpU+RnO2NlgvVREGrlGDTcyHaRqFbEzIf/mIJTh1iAkUogThBS84pu6s8IT2vKgAhoexzpMBUC00U/hhfOwRBP1HsdMkk4r2r17rGsQsioHoQToS4cKFLreFGzeqZivro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XKhitnH8; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20c5fdd0fe3so26465ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 11:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728411135; x=1729015935; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZLNgHa4srZj0Mj779t5wUVINDT2m3pKrdkBQ7dK1eHE=;
        b=XKhitnH8xx02Lx74q+kNI05rV4EM27pagjiY5lyI5FGWpmB7AYg2Y146oreAlf9gwC
         jq+mpASdxGWDQcwz7ykMLY+y9aAkFTZTokqV0UgPSWdiy7rI2jRczjVw4x5rSdpd1rFA
         7YskH287Eq8hOkFWs+WbPpXl55cCytrAIvX6aXgKv5ik8+RKDu8kQseAEycClJwngwC4
         sBxkzPLUm7GWhs4SPH1vb8i9bec/JAkv6nAeiZCIyP2Rh72Gb0R7zBYNEWgJczRWKaX3
         urcLoqJ+9ka9YIqWpXQbtWCAekVmhJvXtX8xw9gC1xttT3PpuBmEUDjiAsBRGeNIylE2
         F1aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728411135; x=1729015935;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZLNgHa4srZj0Mj779t5wUVINDT2m3pKrdkBQ7dK1eHE=;
        b=cjwutDPiKsEfud2/AoGgaVbmEIBwI0s/R7MfnH/8VUnyZrpU1+BzJmXIkCP0MjLFmL
         2HTSvl+O3CEFykMeJ8DuVr8xvKpYLDdSHfEfIyBMiL1kiZddiwEh2/K3VKgKMW22sklO
         S7WiYtV5dqmrQnL8tFeCubG5d5sWZhWtiut2GY2Mvr9XtW9fziZiP5X2qyxHdgFrHydF
         GKhIOJcWj6W6J+iX+7POHd9fHCHjNpqpGK4KJewDz39pg7bbwa9yKzET8Jkb7c9mkOGl
         7YaGO80MgTHU7Bc/JcXzk0u2pEFBfAD/Ib72NFXO5ekjvpy5aX/ELk63O8HE7m177rHH
         TlXA==
X-Forwarded-Encrypted: i=1; AJvYcCXM/VYJRIfVWxZalx1W4gyfag9GFSlikkyeGDpDOPeeXf4c0hdgmcseDhYA/kqkxJNv9pV+ZnNmOQGazTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxptTg2eSRtitQ9A01+a9HFplR38LF8Gk734DI1gtTm0ROUlhqW
	yoci2znSh8JQw9qze20NYr6y8VNPoqafd5yAYEy7vgSvhPkbw9i2MmwbHthRbg==
X-Google-Smtp-Source: AGHT+IFGbvMNhmGPIjWwxbX/N19uSMRxtazGFYqmRVyqrj+mjywXVsQ6bS22W3yESMUJOnNeL3nZ3w==
X-Received: by 2002:a17:903:1212:b0:1ff:3b0f:d61d with SMTP id d9443c01a7336-20c62b11bf2mr219545ad.24.1728411135048;
        Tue, 08 Oct 2024 11:12:15 -0700 (PDT)
Received: from google.com (201.215.168.34.bc.googleusercontent.com. [34.168.215.201])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f6c4a16esm7084074a12.85.2024.10.08.11.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 11:12:14 -0700 (PDT)
Date: Tue, 8 Oct 2024 18:12:10 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Yu-Ting Tseng <yutingtseng@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 6/8] binder: allow freeze notification for dead nodes
Message-ID: <ZwV1-svdRZCF2x2H@google.com>
References: <20240926233632.821189-1-cmllamas@google.com>
 <20240926233632.821189-7-cmllamas@google.com>
 <CAH5fLggS7C4QdmDFqEy5KARUj+4oNWfstyno3d43joG5haysDw@mail.gmail.com>
 <CAN5Drs3TCGT1rWJjujo3FP3HxnSFUFo5hcWh=4+xhOYzDg4JqQ@mail.gmail.com>
 <CAH5fLgjnyKtXsnPbvCFz64BBRqvWPwh6reM-myWA9AEBKFhcJg@mail.gmail.com>
 <ZvbeCg5Ho6p-VU5o@google.com>
 <CAH5fLgjB-ia+UhE1P8gOxHTdjSJJ1=xKSS0c75AvGA91uo_fEw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgjB-ia+UhE1P8gOxHTdjSJJ1=xKSS0c75AvGA91uo_fEw@mail.gmail.com>

On Mon, Sep 30, 2024 at 03:30:01PM +0200, Alice Ryhl wrote:
> On Fri, Sep 27, 2024 at 6:32 PM Carlos Llamas <cmllamas@google.com> wrote:
> >
> > There are different ways to proceed with this dead node scenario:
> >
> > 1. return ESRCH
> > 2. silently fail and don't allocate a ref->freeze
> > 3. allocate a ref->freeze but don't notify the current state
> > 4. allocate and send a "fake" state notification.
> >
> > I like 1 just because it is technically the correct thing to do from the
> > driver's perspective. However, it does complicate things in userspace as
> > we've discussed. Option 2, could work but it would also fail with EINVAL
> > if a "clear notification" is sent later anyway. Option 3 changes the
> > behavior of guaranteeing a notification upon success. Option 4 can cause
> > trouble on how a "not-frozen" notification is handled in userspace e.g
> > start sending transactions.
> >
> > As you can see there is no clear winner here, we have to compromise
> > something and option #3 is the best we can do IMO.
> 
> I am happy with both #3 and #4. I think #1 and #2 are problematic
> because they will lead to userspace getting errors on correct use of
> Binder.

After talking with userspace folks it seems that #3 would be their
preferred approach. So this v2 patch it the way to go then!

Thanks,
Carlos Llamas


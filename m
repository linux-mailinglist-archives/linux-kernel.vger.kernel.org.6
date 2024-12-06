Return-Path: <linux-kernel+bounces-434936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACAEE9E6D2A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 12:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51AF21639A7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 11:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3CD1FC0F5;
	Fri,  6 Dec 2024 11:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="oN5WRTiS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V48Hcbl/"
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666FF1F03F6;
	Fri,  6 Dec 2024 11:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733483759; cv=none; b=E6xLfih713+s2szIMPYsfpP43J4ypQLj5x3icDV2U2Awo7wMS2KVJ0ygAVQPVOOTmRU+tVDRfWjtDzFsgXsIanSM+B5qutjSjZYVdrfbwqUAw6J0Ac7V7DH9z0Q3SiRltwGmP60old1ScrELDFjwm39frBKm51/sNDxd/l9+ns4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733483759; c=relaxed/simple;
	bh=zYtW3KROQ9knp3hpyg9cBNBQV9D7f54sWOSmLmsPuHo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=cOBNK0B+BtUumJ9FRouxpzhQZ9PtkB1sG+sVWI33Wi4e91sgTZuYytqyNVSuY0I3tD34n25/CXPppXlq+OUIdkBs/cb+fJCkudF+EhFT9fmwXBFzYdSjbeRp1dH8ILt1kd/c4ctPFsFky4okBh2FEWU/mo09ikAp74RXJb124jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=oN5WRTiS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V48Hcbl/; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 401FF254015A;
	Fri,  6 Dec 2024 06:15:56 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Fri, 06 Dec 2024 06:15:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1733483756;
	 x=1733570156; bh=iZImz2EXlCSkE34ewWUTPZ2Fp3jhdKpehxcC0543TJw=; b=
	oN5WRTiSh7pGPD85WaFpzwpiP22o/7bwrlyhKHffQRcvSZ0dj9+KN1YLJMcc9/c9
	GBIY+cGKt+W86HF74FZ9Qo378QYxV1mzIxGuOGO2y+kXMzz3yrMJ2Iy5KyiqwBbc
	PkmPwT9JS259Z/oOUeMe/Owd8h/xyVb3dB6RVjYtlTGl4o86HhAImxPVcPg7UtUW
	Lq/ZQV4DUBXYkPdMX+/2x2MYQRRTIyi3wUVmypUuWKeSctDSeO6rOl0/XwsELANY
	w4n10o8t7xjxM9oFGB3dbFDc2W9dbkNJO8YJbmEBX1L0J/SPy/igg7KhEuwWNG1y
	/HcVy2eOwkh/VPeJwBE36A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733483756; x=
	1733570156; bh=iZImz2EXlCSkE34ewWUTPZ2Fp3jhdKpehxcC0543TJw=; b=V
	48Hcbl/gU/4Ix1JPDIfZGjghXAi5RHTaoZexNPZEBXyezIMakDMPNYOuk3e/LQmy
	JaNtB4GU5eUcJkP7kCiLVgYaFVPOhvsYTz4c2qA31mQDdQb/HTKdfb0lJdxmypv1
	GExoL742t76fxLBWN7naishZD9B7jLs+vELVDYGciiVruRgiyEB3O9D4NG53ynTc
	tPLZ9PZbKS4/Y9ElvVEl+GYtKoGN828ED1SWNCvgy+Kd9z2hO1dGcPsQPGzWi/45
	zKHv34P7pCV523MGk99XUtULmbYJmoHj5G+E7Y3yCSjiiLkvMzq6hO6y0vNR25Rh
	6Zxs8NKmFCVJyG+MiI7tA==
X-ME-Sender: <xms:69xSZ-rdm1QM0vMRboCjLsZZcjK36g53--lPX-Qh5OTZiUDaKo8_oA>
    <xme:69xSZ8rUa9fRhS4ygK4PNvf2qV9dkZ9jNdcBAUNe0-SltesWLA7jHX779vWpEHAfw
    SpiUhXXkM5Tsj-Cb4A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieelgddvhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeen
    ucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdrug
    gvqeenucggtffrrghtthgvrhhnpedvhfdvkeeuudevfffftefgvdevfedvleehvddvgeej
    vdefhedtgeegveehfeeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedufedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvg
    htpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtghomhdprhgtphht
    thhopegsohhquhhnrdhfvghnghesghhmrghilhdrtghomhdprhgtphhtthhopegrlhhitg
    gvrhihhhhlsehgohhoghhlvgdrtghomhdprhgtphhtthhopegrrdhhihhnuggsohhrghes
    khgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhgvvgeskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhrvghgkhhh
    sehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepsggvnhhnohdrlh
    hoshhsihhnsehprhhothhonhdrmhgv
X-ME-Proxy: <xmx:69xSZzNur-efEtDl_JqYqSdMFVOJAvJIUmMUerqgtLw_ZMSLJ-USvg>
    <xmx:69xSZ94pm1jdgM_38frAQBZ6I8Ra69hyJSq_kri1va-fbBPGSBqqsw>
    <xmx:69xSZ94LmnpFwUFn_ogcDP7ntCp78KL434n3PsSTAE2F83UzwaXDMQ>
    <xmx:69xSZ9gdz4_fLqkYJfCSN6AD8YoGgDTmbi74SqfPRmQkBxqEK8FKmA>
    <xmx:7NxSZ1zyg5e20d3sIy-1J_vibNbINuPSDz-Y5WOy9Nrtl685pVy8FO4->
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id BE0C92220073; Fri,  6 Dec 2024 06:15:55 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 06 Dec 2024 12:15:35 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Alice Ryhl" <aliceryhl@google.com>
Cc: "Lee Jones" <lee@kernel.org>, linux-kernel@vger.kernel.org,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 "Benno Lossin" <benno.lossin@proton.me>,
 "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Trevor Gross" <tmgross@umich.edu>, rust-for-linux@vger.kernel.org
Message-Id: <592946c7-ab76-42c5-977a-fcad04b0c439@app.fastmail.com>
In-Reply-To: 
 <CAH5fLghxCn07bHgfqMJz3p=ak6f9KNOWVUtiCmT1nmKvsk0OwQ@mail.gmail.com>
References: <20241206090515.752267-1-lee@kernel.org>
 <20241206090515.752267-5-lee@kernel.org>
 <57c35f7f-76e8-4e21-8288-c66a1b6e7069@app.fastmail.com>
 <CAH5fLgjauL-1QbnkVVK34COD_Ch_rcdpUEMKBsC9HB-TKWNscA@mail.gmail.com>
 <2073da49-37c6-4add-9450-47842d05cd79@app.fastmail.com>
 <CAH5fLghxCn07bHgfqMJz3p=ak6f9KNOWVUtiCmT1nmKvsk0OwQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] samples: rust: Provide example using the new Rust
 MiscDevice abstraction
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024, at 11:40, Alice Ryhl wrote:
> On Fri, Dec 6, 2024 at 11:31=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> =
wrote:

>> I wonder if we should change the prototype of the ioctl
>> callback to always pass a __user pointer and just not allow
>> the few commands that pass an integer in rust drivers, and
>> worry about it only when it's absolutely needed.
>
> One option is to let the Rust Miscdevice trait have three ioctl method=
s:
>
> fn ioctl(cmd: u32, arg: UserPtr);
> fn ioctl_raw(cmd: u32, arg: usize);
> fn compat_ioctl(cmd: u32, arg: usize);
>
> Then when building the fops vtable, we do one of:
>
> 1. If `ioctl` is specified, use that implementation with compat_ptr_io=
ctl().
> 2. If `ioctl_raw` and `compat_ioctl` are specified, use those two
> implementations.
> 3. If none of the above are specified, use null pointers.
> 4. All other cases trigger an error at build time.
>
> Thoughts?

I think we can combine the latter two into

fn ioctl_raw(cmd: u32, arg: usize, compat: bool);

and only need two cases: either all arguments are pointers to
structures with compatible layout and you can use the simple
ioctl() callback, or there is some special case (incompatible
struct layout or integer arguments) and you use the raw
version. I think this would work just fine.

Or we could take it one step further (going back to the
discussion we had the last time this came up) and make
the default version copy the data as well and pass it
as a kernel pointer. In C code this would look roughly
like

long file_ioctl_wrapper(struct file *f, u32 cmd, unsigned long arg)
{
       void *argp;
       void __user *uarg;
       bool compat =3D in_compat_syscall());
       size_t size =3D _IOC_SIZE(cmd);
       int ret =3D -ENOIOCTLCMD;

       /* Get a pointer argument for both native and compat mode */
       if (compat)
              uarg =3D compat_ptr(arg);
       else
              uarg =3D (void __user*)arg;

       /*
        * allow .ioctl_raw to provide a custom version for
        * commands that take an integer argument, have an
        * incompatible compat layout or fail to encode size
        * and/or direction correctly in cmd
        * This can return ENOIOCTLCMD to fall back to the
        * simple handler for other commands.
        */      =20
       if (f->ops->ioctl_raw)
                ret =3D f->ops->ioctl_raw(f, cmd, uarg, arg, compat);
       if (ret !=3D -ENOIOCTLCMD)
                return ret;

       /* No data, so skip the allocation */
       if (_IOC_DIR(cmd) =3D=3D _IOC_NONE || size =3D 0)
                return f->ops->ioctl(f, cmd, NULL);

       argp =3D kzalloc(size, GFP_KERNEL);
       if (!argp)
             return -ENOMEM;

       /* _IOW or _IOWR, so copy data into the kernel */
       if (_IOC_DIR(cmd) & _IOC_WRITE) {
             if (copy_from_user(argp, uarg, size))
                    return -EFAULT;
       }

       ret =3D f->ops->ioctl(f, cmd, arg);

       /* _IOR or _IOWR, copy back even after command failure */
       if (_IOC_DIR(cmd) & _IOC_READ) {
             if (copy_to_user(uarg, arg, size))
                    return -EFAULT;
       }

       return ret;
}

With this, every driver that has a properly designed
set of ioctl commands can just use the simple .ioctl()
callback, and any commands that need some special case
can be put in the .ioctl_raw() callback.

If this works out for Rust, we can actually put that exact
code into vfs_ioctl() and add back a .ioctl() callback
into struct file_operations next to the C .unlocked_ioctl
and .compat_ioctl handlers.

    Arnd


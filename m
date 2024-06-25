Return-Path: <linux-kernel+bounces-228918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A839168A5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 15:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EB7CB2638B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 13:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF7715AD8B;
	Tue, 25 Jun 2024 13:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z+ZfQmug"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3D4158D97
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 13:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719321142; cv=none; b=emYNfdCr7HDpJI8VKjbFT+TwwHBiLMbrR7mrXsEwxhg4i2O3HmpSi7AlOTqhZVo5ixmoa/Vm/gIJg8WDql5eYEkprsrjZ8r7PABMbtrAlahwYwjA+kglI0XjMMkW+07AhBF3JLSYZHVXMOzrafu95x0hNeR8gu8M9+TyOCxjnJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719321142; c=relaxed/simple;
	bh=TFq4HLn3CLeNg6JyyyzAe6Ha+Upr2kIV3iKB8OJpY7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IuFgW8CA3rfzFyeyZy78ipizUJXct1TyWl7/uuQ1F2R8WsBGzjast9HgUAUujXWjp3+cMu9BQcutEysodVyg561sRFFcA9S42H0vtvOTs7AhbZO9iCkxhDELHzfbZkjJ5sXXxac2UoRf78mfVgZzyZQTRv980ScN9QK7FoPNdRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z+ZfQmug; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719321139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jh/orAWdmX1f20UeUuohMffT1uAlWu31wkSvgtgeopA=;
	b=Z+ZfQmugUiJ2K3b8UtbZ5bs+O/E+tPsN2CVRIlG1ACj5dloEuDl52n3C3v2S4F0b6lLa+M
	LMgKNe3SQzcyt5PPV3kt7VOXMt1ZdIuzCEgRHkabvL3tSM8Bw9C97qIIq12CE5k8iPSTdF
	2FppdPrfVyPR6BsP3d8CYZAm0DwRgQg=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-v38kdomkNzaiqvC7_ZZBHQ-1; Tue, 25 Jun 2024 09:12:17 -0400
X-MC-Unique: v38kdomkNzaiqvC7_ZZBHQ-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-52ce3a9a2daso1939313e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 06:12:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719321136; x=1719925936;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jh/orAWdmX1f20UeUuohMffT1uAlWu31wkSvgtgeopA=;
        b=umlxD8jZP1C6rvJpchuKxJRp+6fIjhE08s6vN4HEfbjBIQoPMT9dIyL3flF3iW/epA
         6kDdkmswc+BRPAnkxkUzQDWDGAxF68dQWTqAkzhlKjX931xeXfGvMU1eKjtZOqGTyEII
         MTYAekYjRPoq5oM4pP5Yuwihf0oxDE3fGcXc4wXdPmZDpWykiAILcRIHpNBIOtZZR+hj
         C9ni6uCLBNg2ymrPuk+6UmxfNfMSh8N9d9c/YY0DrjBhKXLOd6lBgE5OUbxdm9OUSBnX
         CfKjcGc22cXmQ2ijtXbLVIZBqNXv/BbLTIY2IO9C43sabX7iigm1MwkGG1Plbp+bWax3
         WoNw==
X-Forwarded-Encrypted: i=1; AJvYcCX686iyZpTzlDV2kUU8RT2gMhZoV89c1o4fKfKHI8v+A/0WB7YWDVZ4Gq2aXejestvcXDfWYHGLpLgWCo9DWg4+7qGV6FOUvRq3Cyr7
X-Gm-Message-State: AOJu0YxL6+/msoVPFKkND07qaTGUryeN46VQF2Fjnd7iL3cJFJyUl7VI
	PcV8Y1to9FHR72sRNeo3OaILnpjw5wqN9BSiZxCWh3kpAcj9WJEbE0z04TOaYgVgK0tS3N8o/GQ
	VO91I6G6krgwiQOHe0cWAjUApRbbRqsdT9L5giGSVqD7SfpBjNHm/F/A0Nr9DqA==
X-Received: by 2002:a05:6512:3285:b0:52c:df9c:5983 with SMTP id 2adb3069b0e04-52ce183b3d6mr3992089e87.40.1719321134543;
        Tue, 25 Jun 2024 06:12:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF35SrdNTXrkT5B2/iGfiGvj53zPOM8OB7zzQf/r/NlUat09myb8xoQxhJ+HmOKZSgeyj5WYA==
X-Received: by 2002:a05:6512:3285:b0:52c:df9c:5983 with SMTP id 2adb3069b0e04-52ce183b3d6mr3991982e87.40.1719321132655;
        Tue, 25 Jun 2024 06:12:12 -0700 (PDT)
Received: from cassiopeiae ([2a02:810d:4b3f:ee94:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36638f85922sm13038812f8f.63.2024.06.25.06.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 06:12:12 -0700 (PDT)
Date: Tue, 25 Jun 2024 15:12:09 +0200
From: Danilo Krummrich <dakr@redhat.com>
To: Andreas Hindborg <nmi@metaspace.dk>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com,
	aliceryhl@google.com, airlied@gmail.com, fujita.tomonori@gmail.com,
	lina@asahilina.net, pstanner@redhat.com, ajanulgu@redhat.com,
	lyude@redhat.com, robh@kernel.org, daniel.almeida@collabora.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 07/10] rust: add `io::Io` base type
Message-ID: <ZnrCKQBaRUlIs8hp@cassiopeiae>
References: <20240618234025.15036-1-dakr@redhat.com>
 <20240618234025.15036-8-dakr@redhat.com>
 <87zfr9guer.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zfr9guer.fsf@metaspace.dk>

On Tue, Jun 25, 2024 at 12:59:24PM +0200, Andreas Hindborg wrote:
> Hi Danilo,
> 
> Danilo Krummrich <dakr@redhat.com> writes:
> 
> [...]
> 
> > +
> > +macro_rules! define_write {
> > +    ($(#[$attr:meta])* $name:ident, $try_name:ident, $type_name:ty) => {
> > +        /// Write IO data from a given offset known at compile time.
> > +        ///
> > +        /// Bound checks are performed on compile time, hence if the offset is not known at compile
> > +        /// time, the build will fail.
> > +        $(#[$attr])*
> > +        #[inline]
> > +        pub fn $name(&self, value: $type_name, offset: usize) {
> > +            let addr = self.io_addr_assert::<$type_name>(offset);
> > +
> > +            unsafe { bindings::$name(value, addr as _, ) }
> > +        }
> > +
> > +        /// Write IO data from a given offset.
> > +        ///
> > +        /// Bound checks are performed on runtime, it fails if the offset (plus the type size) is
> > +        /// out of bounds.
> > +        $(#[$attr])*
> > +        pub fn $try_name(&self, value: $type_name, offset: usize) -> Result {
> > +            let addr = self.io_addr::<$type_name>(offset)?;
> > +
> > +            unsafe { bindings::$name(value, addr as _) }
> > +            Ok(())
> > +        }
> > +    };
> > +}
> > +
> 
> I am curious why we do not need `&mut self` to write to this memory? Is
> it OK to race on these writes?

Yes, concurrent writes to the same I/O mapped memory region (within the same
driver) should be totally fine.

In the end it's only the driver that can know about (and has to ensure) the
semantics, concurrency and ordering of those writes.

> 
> 
> Best regards,
> Andreas
> 



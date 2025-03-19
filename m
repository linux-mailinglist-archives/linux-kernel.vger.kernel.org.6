Return-Path: <linux-kernel+bounces-567130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30341A681AE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 01:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CBDF175CFD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 00:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19B84204E;
	Wed, 19 Mar 2025 00:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="OuvlnTKG"
Received: from mail-10628.protonmail.ch (mail-10628.protonmail.ch [79.135.106.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F515D2FB;
	Wed, 19 Mar 2025 00:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742345444; cv=none; b=FUgc2DbTKEUOzIB/RorWo+umyPboPibm56JyaYkKdACZiP0jBXmoWcB4Ks90I0p086dJPA23d9CvHg+cGCknRlFfHwVHIcElNpd9cAIrd3pFvaHLTnedeeyIpdbI0mBDFrgknmsHeXrdoa4fgpf3XdAAk4XbTEMqb5NGMuaZgK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742345444; c=relaxed/simple;
	bh=NeEU7i74gwTAa1WttGzCW7vliZqsygMpqhOWUejssws=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tddNr9vtpyNDCl8baYnKEfFEMP/9EalkP33v5fMdnFw2SUfc9i+XKCtgw52AXh5WFmFYhm10/HC2CKlPDxA2zdEqfJ8CRfbcKhyURiLniE+MpPRVOduIgmNG64yyLkTo9ByqVhMxXbTf8dSNGD0r3uSXG6XISfDOoqcr5WkoDaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=OuvlnTKG; arc=none smtp.client-ip=79.135.106.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=6jba5to2fzf2tmn4smqyqpdmoq.protonmail; t=1742345439; x=1742604639;
	bh=VkL2Mxif+LYFPEMvRY4YuHUJQ31AetP3+c0xD9LJp+0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=OuvlnTKGDYLlG88upDBw7wr7g3AGCYM0aTNk3kRAoVprUuW+CF/kqquXw1cSicdLT
	 uVn/H329nesx/xyayy2Fazl1UVyHZV/K9jTFAG2dKFAG0dRAq2X9EKmPTvy44/LhqH
	 UHiRD60+7g1KXwgS4aJRWHPWE1eO7El1z6MIJnTGMDd/5NPPy77oQsWCNSa40MHR0S
	 +WoI4I0EQk/x2iIHvxkVkXQ4zY4IbT36G7wYMVsFjOsIpmc8INPwpP/zzcrIZZVBJD
	 ylra/qToQwv/F1EBGmh2weZubQEmvOe9vyQrqoJEt34Dm4R4WYR1Ork8tDUjgM+Fbl
	 mmXzZ4qWCyItw==
Date: Wed, 19 Mar 2025 00:50:29 +0000
To: Tamir Duberstein <tamird@gmail.com>, Andrew Ballance <andrewjballance@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: dakr@kernel.org, airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, corbet@lwn.net, ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, acourbot@nvidia.com, nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 2/3] rust: alloc: add Vec::resize method
Message-ID: <D8JTWL8JY7DM.3IVH6FZ4M49CB@proton.me>
In-Reply-To: <CAJ-ks9kAROOfyPtxMe6LE4-UPsvXca2sQ2VDjhRchZp3HLddGg@mail.gmail.com>
References: <20250316111644.154602-1-andrewjballance@gmail.com> <20250316111644.154602-3-andrewjballance@gmail.com> <CAJ-ks9kAROOfyPtxMe6LE4-UPsvXca2sQ2VDjhRchZp3HLddGg@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 124220e04b60981fd23d64c8176e2b18357079aa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue Mar 18, 2025 at 9:12 PM CET, Tamir Duberstein wrote:
> On Sun, Mar 16, 2025 at 7:17=E2=80=AFAM Andrew Ballance
> <andrewjballance@gmail.com> wrote:
>> +    pub fn resize(&mut self, new_len: usize, value: T, flags: Flags) ->=
 Result<(), AllocError> {
>> +        if new_len > self.len() {
>> +            self.extend_with(new_len - self.len(), value, flags)
>> +        } else {
>> +            self.truncate(new_len);
>> +            Ok(())
>> +        }
>> +    }
>
> You can avoid underflow checking in debug builds by using `checked_sub`:

`checked_sub` doesn't only avoid underflow in debug builds, but rather
in all builds. But the code below is a good suggestion.

---
Cheers,
Benno

>         match new_len.checked_sub(self.len()) {
>             Some(n) =3D> self.extend_with(n, value, flags),
>             None =3D> {
>                 self.truncate(new_len);
>                 Ok(())
>             }
>         }
>
>>  }
>>
>>  impl<T, A> Drop for Vec<T, A>
>> --
>> 2.48.1
>>
>>
>
> Either way:
>
> Reviewed-by: Tamir Duberstein <tamird@gmail.com>




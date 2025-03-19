Return-Path: <linux-kernel+bounces-568186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D54A68F4F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 15:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CCDA3B928A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 14:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5F81D9A50;
	Wed, 19 Mar 2025 14:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="XMoYDFA9"
Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87091D5CE7;
	Wed, 19 Mar 2025 14:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742394862; cv=none; b=rjAPfUg2zCyIAUDJ+qxBgxcb9+ZFNokecHQmFRjFkZDK06myHbHgHgkJd0E+2xLWcOVCuQuXVJXJCc8g/LS67Bffs/gZpoFFHgULVEgDw+n/Q2H4f/GpYBIkzmLifvEEBfm5z5fKik8UyWCw9PC3Qd2V5yuXtLXzw/uRte55/c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742394862; c=relaxed/simple;
	bh=eM3eGc5ovDj2/KdYVo8gN/gmXx/DSmVPxyyfG8cPR5o=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=riuJ051Tl1UqqhHRMOaQpbJ8skbqUBKYu8CU6AuwLMEcI46X3Hb0NNZkzoMWVAESz31LhEMmBdnUUuJDEjoZJ5iSsHXc8nwNl/zji+D8+uNATxxWwqlNw6s42n/AvUii6A1zwkuhXn5oEaQJ4qiA9Nl47vnB2t5AIJGT3pWpJ8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=XMoYDFA9; arc=none smtp.client-ip=79.135.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742394858; x=1742654058;
	bh=1z4dJFA1oF0CRRS/sExQ1v3obrgN9+5/FwLBH297BOY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=XMoYDFA9E4VJhCiq6RWj9hUWXDW1RXu5dTWuuMTLu2ZXX1uQosPiLRnfED+LRlnrK
	 7jTWKnnGyl7rs4+AKxtswN5p3jlJxLvD2e5zyFI2EeVYZYtzN+eqwb6eeuuPvG+j4y
	 TyG9DOFNa8InpV9OEOZbDn6dz4Lzokya8A6WViRztDXVOvjPMskM3cgfztWmXD+fon
	 GmHnTgLNARNkMKInCTT8z2hy3tdCSjRJ8phuKFfRHHgGwfZgZYIxtNA+O36/+FHXNy
	 XDNTdzW5j8zdLOoaLpL+VNm211+4QtNxZeaLCsfytlTJYUEDkfduqkED6y4VVZ2VJy
	 Ravj30YhjkgwA==
Date: Wed, 19 Mar 2025 14:34:13 +0000
To: Tamir Duberstein <tamird@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Andrew Ballance <andrewjballance@gmail.com>, dakr@kernel.org, airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, corbet@lwn.net, ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, acourbot@nvidia.com, nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 2/3] rust: alloc: add Vec::resize method
Message-ID: <D8KBFC9M74H5.4ZJ2SJK06SGR@proton.me>
In-Reply-To: <CAJ-ks9k+A1+0CWXZmD2m0+jRqTRTNFn-=d9VXqytiOqvn4BR0w@mail.gmail.com>
References: <20250316111644.154602-1-andrewjballance@gmail.com> <20250316111644.154602-3-andrewjballance@gmail.com> <CAJ-ks9kAROOfyPtxMe6LE4-UPsvXca2sQ2VDjhRchZp3HLddGg@mail.gmail.com> <D8JTWL8JY7DM.3IVH6FZ4M49CB@proton.me> <CAJ-ks9k+A1+0CWXZmD2m0+jRqTRTNFn-=d9VXqytiOqvn4BR0w@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 7359374f116b2f0b801718ab9a5a44bdad44f80a
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed Mar 19, 2025 at 2:42 PM CET, Tamir Duberstein wrote:
> On Tue, Mar 18, 2025 at 8:50=E2=80=AFPM Benno Lossin <benno.lossin@proton=
.me> wrote:
>>
>> On Tue Mar 18, 2025 at 9:12 PM CET, Tamir Duberstein wrote:
>> > On Sun, Mar 16, 2025 at 7:17=E2=80=AFAM Andrew Ballance
>> > <andrewjballance@gmail.com> wrote:
>> >> +    pub fn resize(&mut self, new_len: usize, value: T, flags: Flags)=
 -> Result<(), AllocError> {
>> >> +        if new_len > self.len() {
>> >> +            self.extend_with(new_len - self.len(), value, flags)
>> >> +        } else {
>> >> +            self.truncate(new_len);
>> >> +            Ok(())
>> >> +        }
>> >> +    }
>> >
>> > You can avoid underflow checking in debug builds by using `checked_sub=
`:
>>
>> `checked_sub` doesn't only avoid underflow in debug builds, but rather
>> in all builds. But the code below is a good suggestion.
>
> Yes, I know :)
>
> I included that language because the underflow check is likely
> optimized away in release builds.

If the function is inlined and the compiler can argue that `new_len >
self.len()`, then yes, but otherwise I'm pretty sure it won't be
optimized away.

Also if it is optimized away, then the check was still "executed", so I
find it a bit misleading to say "in debug builds" (making it sound like
it wouldn't do it in non-debug builds).

---
Cheers,
Benno



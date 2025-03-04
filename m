Return-Path: <linux-kernel+bounces-544275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BCCA4DF90
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7DBC189CB37
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4B5204F76;
	Tue,  4 Mar 2025 13:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHaYIPdZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224D020469F;
	Tue,  4 Mar 2025 13:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741095847; cv=none; b=hDKuqvEl1GE9fh9kcPjB+Wy4AwLUAvegq+Wvl88+QBPmVIYOTTAnqF+UCGpHTa6RaCaXepdICTkucLRoDh3rI0jvA0yOqCAJXESRF4Q+w9ZkU1X7Hs+JDkVdLzMpqMNqh3XaPwtoZCXKtSqVd1fu231Jl80+5hawis1XfQK+kcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741095847; c=relaxed/simple;
	bh=B/OYmvy9zr76agLhnG0ycC+hDadBQqyUMPzhZTGcanM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NgSpEy0jLvaJmI95UGPoSp3speQ1YkVAcBBx+e0cdcu2gy2XB/CKABsHrdc7MzhEUzRaA01VDOmEZO24bntyIGYlgf7CRRxQsohIJymxc8neLnu883Y9xK/JfFKMzE6gntiXlOXEqJLcF5XyQm6SjtfAvjreNEO915lpT9Vn10E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GHaYIPdZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BFDDC4CEE5;
	Tue,  4 Mar 2025 13:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741095846;
	bh=B/OYmvy9zr76agLhnG0ycC+hDadBQqyUMPzhZTGcanM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=GHaYIPdZB+3UljcK2WXyQXDq+T9ZSbm/1EV7+xgFEyBmpEG7aNwiAmIEvav0i57n5
	 R+x8B7q/vCA+kQSUXQBO6Hcw6kua+dMeNcktLTC35whgzDglHoGtM7GL1oFrLqINF2
	 RpYHZHPsE/H+qjUNtp+CKm8iDiBzFNIdACL+SPF4mYIOoqmAVg2qU9Vgxc82hwyYP/
	 c9DEKunX7RPzayF26nR3NjICU+kN9QofOR412fFlQ+4g7J0qD36PXz95ncl1Qu4Yy2
	 v/q/GgqqnrHiANFJAovw31SjDC3DDKjml987HDer3c86Mhpy31HU5VNPLpZpKD0sLb
	 IY0wW22zban+Q==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Daniel Almeida" <daniel.almeida@collabora.com>
Cc: <ojeda@kernel.org>,  <alex.gaynor@gmail.com>,  <boqun.feng@gmail.com>,
  <gary@garyguo.net>,  <bjorn3_gh@protonmail.com>,
  <benno.lossin@proton.me>,  <tmgross@umich.edu>,
  <rust-for-linux@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  "Alice Ryhl" <aliceryhl@google.com>
Subject: Re: [PATCH v2] rust: irq: add support for request_irq()
In-Reply-To: <D058ABBE-A0E8-4D95-AA4F-31EAA4092A73@collabora.com> (Daniel
	Almeida's message of "Mon, 10 Feb 2025 05:41:17 -0300")
References: <20250122163932.46697-1-daniel.almeida@collabora.com>
	<P6uxHjNnFZn4JOtisJbsPvyFH7-7YjYa8rBGb0bWMZzVN6dJI2V3ULxonvji7BsHT6nn5oAq0cI5R9RvhqzExA==@protonmail.internalid>
	<D058ABBE-A0E8-4D95-AA4F-31EAA4092A73@collabora.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 04 Mar 2025 14:11:00 +0100
Message-ID: <87ikopgcuz.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Daniel Almeida" <daniel.almeida@collabora.com> writes:

>> On 22 Jan 2025, at 13:39, Daniel Almeida <daniel.almeida@collabora.com> =
wrote:
>>
>> Add support for registering IRQ handlers in Rust.

[...]

>> +/// use kernel::prelude::*;
>> +/// use kernel::irq::request::flags;
>> +/// use kernel::irq::request::Registration;
>
> By the way, I wonder if a re-export would be beneficial? I find it a bit =
tedious to specify this path.
>
> It also clashes with kernel::driver::Registration and kernel::driver::drm=
::Registration, so I find myself
> continuously writing an alias for it, i.e.:
>
> ```
> Use kernel::irq::request::Registration as IrqRegistration;
> Use kernel::irq::request::Handler as IrqHandler;
> ```
>
> Looking at mq.rs <http://mq.rs/>, I see Andreas did something similar:
>
> ```
> pub use operations::Operations;
> pub use request::Request;
> pub use tag_set::TagSet;
> ```
>
> Asking for opinions here since this is a bit cosmetic in nature. IMHO, at=
 least the =E2=80=98request=E2=80=99 part of the path has to go.

For block I usually import `mq` if there can be clashes, then I can use
`mq::Request`, which is not so bad. I think a reexport to make
`irq::request::Request` available as `irq::Request` would be nice.

In `mq`, most sub modules are not pub, so the only way to reach the
types is through the reexport.


Best regards,
Andreas Hindborg





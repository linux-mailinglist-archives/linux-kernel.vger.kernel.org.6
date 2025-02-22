Return-Path: <linux-kernel+bounces-527173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F0CA40818
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 12:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9480C7ABC6B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 11:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545E320ADD5;
	Sat, 22 Feb 2025 11:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kl850M0g"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708AF1FA16B;
	Sat, 22 Feb 2025 11:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740225207; cv=none; b=j+5g/n1O7BraCBc2XtyuRBdK5r4UMjyyVoEeUiXelnIeyKPeO3SxLv0/LACWJGmhjq4YTQRxQrExWyuYhD+zQNzvX+Dt0c9mf5WVWQFvCLeXLKUpl+SzF275dRQx3pIwYfEvQsbGq2NhqtCySo4E0EJskrr/Zr90bPXp88oXvPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740225207; c=relaxed/simple;
	bh=Ywa8seRgiXJKAoc3NuNrg+fonkZ9rGkNq5KSYrwrmWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AVQQcV/owQjwOxBA9rCDiuH1h5bnh5QjyHRAcMox36PF2V4ojpouzFlUG8dYglSsqKxqBfejW+/BN9a5vyawcRlQjWbSnH4z7r8ry7AsL+4yv0w0AlJ8eMkTSWLSvlUNj0EOdtuu3YmF3C76PYybazUJ/hDMtoyn6KoUVNCXoxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kl850M0g; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2fc317ea4b3so767584a91.3;
        Sat, 22 Feb 2025 03:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740225205; x=1740830005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ywa8seRgiXJKAoc3NuNrg+fonkZ9rGkNq5KSYrwrmWA=;
        b=Kl850M0gpyZ/hFLJjyrsfXTO+72Id7BOMQ3l714x2gQJ7X99m4v/4XgGEFxhCZPseq
         V0z/fT6indjAbJWD+3nZq4LIazaBfWrITzwsUzXHBMn2Ce9hy7YUnLenCEpG26ZEp2zs
         Pd82fANjPm4SLbeRLrTIVlovVzGRVAh6AYDd7MA/wYfpnIvXpafb4EnS5q8Y3Gr9jKok
         e1+9FYdDCOzOMLtWaB7Ky5NLtfc4oZgKyYvGOg+KJHYvO5Z+fK0L1p71etB/VVuj72U/
         EzHYrF7l70mwQ2WSdhJ9OEIMTxCXqwPNvzEaL1JDR2yQiIKju77H/0Blw19ex91Tz1+e
         VBYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740225205; x=1740830005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ywa8seRgiXJKAoc3NuNrg+fonkZ9rGkNq5KSYrwrmWA=;
        b=FXBD7CrMohXVyZPfCXR1eXfVgZUknq49OH4qZBwI4SM82f0y19HKcsFQbnd/rvi01d
         8lgLz8V7APsoaelSgTJNh4/l0i5UBfRQMDZTwGLNywEBgGh1dzWbH/P3ZEljS5rdFU9v
         mX+NM0O2BIJRtNSgkZGMZ6yT+U3ZiMNjBEqmdp5wTl0qjzFTtqUv/J5lGO+oSfa7BXzU
         f/pxh14JgC25edO6EjubKUwJP50M8fp2rUZ0KdwGtNCMCU3n/CVEgV9YF2H/cxb3FHJc
         Cdux3VV2grUCsBRNwtKH8P66BSBhSlr2xL7pYDlAVcmWp16yjykBlvQeY4j4NxH2IMTR
         lfuA==
X-Forwarded-Encrypted: i=1; AJvYcCUsaWtrvQD99G4dRkhvG7J8DqA2ZJwlrkmny0e1a3XcX+id94t2Sg4UyBPT3SZ5d9HntBRFu0kNDTPgd6kmA0M=@vger.kernel.org, AJvYcCUvtdCs6J0QwmwdISnKVt39xUEAj4SM2wy21O/rReZ8G7SeMgoL8VhGQ3HJ85isROs//M0fVR2JNy1v1/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtBmDGY0s2j+s7TM0358yo+UM9mUUQWf/qg5QmmvM+5xjklv4k
	AWOOAHDb+pypjoR4mkySrBq6tl0Gd+Ks636GttMPzwBiG41iSUmP40L/Xm2ALTBG0xcBLkPEBnj
	x9EZ5A31onaLGG44YS72oa5SHq/Y=
X-Gm-Gg: ASbGnctRYdvXEGjMG/CzaH2xzgrn6NN65TBWzfOr5xVWwD4BHfDVm3PjQl58bSBqrtO
	CTgADwXKqzDvis/0g16VyHeXZh8ozyNP3wrlSOuCTlzAyfRZ3c8qslBv7IyIU/OgU3bY6WW7Cqx
	0zmNGeA2M=
X-Google-Smtp-Source: AGHT+IHWmt4RTi2qau5wn0wDQz+aqI9/+srVZOUk/gunDyRzExzVvDc1QfC7JM/S9mOB0zaIP6O1zXz6kjfUASOXH1I=
X-Received: by 2002:a17:90b:3a81:b0:2ee:b665:12ce with SMTP id
 98e67ed59e1d1-2fce789cc70mr4290451a91.1.1740225205477; Sat, 22 Feb 2025
 03:53:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221223533.158959-1-hamzamahfooz@linux.microsoft.com> <Z7lPcy6mgOVSFhZr@kernel.org>
In-Reply-To: <Z7lPcy6mgOVSFhZr@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 22 Feb 2025 12:53:13 +0100
X-Gm-Features: AWEUYZm_OGFROdvVMkCAYnPd0bj7BM5p5R_V6-j5E5w23_iwWVGJInQD7LkMDAY
Message-ID: <CANiq72ktfkBLyVxx9-4UJZuvk5QdLpR9iP5R7BA6MUtx0KNKUQ@mail.gmail.com>
Subject: Re: [PATCH] rust: workqueue: define built-in bh queues
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>, rust-for-linux@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Wedson Almeida Filho <walmeida@microsoft.com>, 
	Nell Shamrell-Harrington <nells@linux.microsoft.com>, Dirk Behme <dirk.behme@gmail.com>, 
	Konstantin Andrikopoulos <kernel@mandragore.io>, Danilo Krummrich <dakr@kernel.org>, Roland Xu <mu001999@outlook.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 22, 2025 at 5:15=E2=80=AFAM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
>
> Using 1st person plural is usually almost a cardinal sin almost and is
> somewhat exhausting to read.

Using "we" is far from a "cardinal sin" -- even key maintainers use it
sometimes.

Yes, commits should be generally written using the imperative,
especially for the sentence about the actual change itself, but it is
more natural in some cases to use "we".

> "These methods" refer to nothing

"These methods" refer to the ones added in the commit -- that seems clear t=
o me.

They are not "methods", though (that is wrong), but apart from that, I
am not sure what the issue is with those two words.

To be clear, this does not mean the commit message is good -- I agree
that it should provide more justification.

Cheers,
Miguel


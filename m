Return-Path: <linux-kernel+bounces-548002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08ECBA53EB0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 00:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 436FF3AB4F9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 23:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5437A207A3B;
	Wed,  5 Mar 2025 23:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2ZFcOc2"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B0E4A06;
	Wed,  5 Mar 2025 23:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741218938; cv=none; b=uz7S5z0Pa4yld2iBGpSkKLHCHU7PEfGuxP2hmQ3uSQcsHUMbo3t/DqtINPdlPRxdc8R+1lC7KNm5sq6RFx4q+Q8zR8GlubysV/cQ5cQfrZ5bY0P34sDhMMNeG3KSzVG3taXgArLBdjf24qayQUu1JwO8KbPW1Jjny7Bfrj3UyE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741218938; c=relaxed/simple;
	bh=09myHZqFz0X5dCEv1x8Z5EOSdfzJmm3vhAIz3wlbHiI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L/Vx7pmdH47rEQapqaAl1ClXZUEAXKDqMSB8Ts9CjzJxrcWpYZ+G9g4aqwEMkS7YarcfeBn5bguDGW4VcrL6NMJr2HFmmZh1kwqwJFrtDAAkCexzsshzM5ziEsVVzqawpFQhJsX0OItIbyd/orBwBOaaHFzmJaz5zlFhHpdg+cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i2ZFcOc2; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30be7eecc2bso93601fa.1;
        Wed, 05 Mar 2025 15:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741218935; x=1741823735; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=09myHZqFz0X5dCEv1x8Z5EOSdfzJmm3vhAIz3wlbHiI=;
        b=i2ZFcOc2r79IUhGz/bh59ds3bHkQckrlGqCBF67xv3oAODod7B8fcwFE6VBIpuMzUh
         PC+KN3+HsSHjirlroQmR6Kf0qTPXz4JEwpgkPXt0eznWdVI8ZQ/5oXcqU8cAoc6TDZif
         YIRS6a0baY2CCuqtBP/TuJnt89Qr+CSF/qATtSGl15QI3iOdkxF9zQPmwb0c/bQFOnxj
         RCD4JnIX7N3kHYlElcP1QY/zNt6VocJ7RgXMKBlyfV48a3Xw2JSRmvkQc62Rw+/ykKAP
         G+6g9951lmfDyLnysMv/ffGEhJIg80nYXQ8ex+o2vmZCF18npyE4CtG6RNgQQGpMcyRk
         cdYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741218935; x=1741823735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=09myHZqFz0X5dCEv1x8Z5EOSdfzJmm3vhAIz3wlbHiI=;
        b=kvBH8QN5FWHOZLp+Nsx+HfSYMojcBy98d9IaJe6LOXQxEeji60qIq0+YIesBrTZ9pZ
         XE7/2Jp34cawhdXhEfqiMJp9J4Lf67OFB2BIuCkulQ6AJxqZWoZW8sWpBC9bzndjuU5k
         XSfDrVl+DKXytMyPxUZqiFZpeUalSc68/1v0O9qeGGzKnHB9H97kJCoAMylA3QkqhbvY
         ttYPBxVDcDyIP2FcEZIauCmBTB/v0f8qn1+1BQWioAIpQ76AHo0Wk7ZNo2tiQzRK9sCC
         /CthottqKANWdEjfIDe5hYVfBdaVgzjIZVVBtvdk/W1d/QuQ9B2JkXjk63AOVC7INBjO
         Na1w==
X-Forwarded-Encrypted: i=1; AJvYcCU6Y//VhDC3hJIxRG+u72btuhJcJvYKoLuM8GpO8+rI7P9Z/o6ApPvNxoqY50tRuo9MfmZmqCSnsywqQzdqsWM=@vger.kernel.org, AJvYcCV2g0rk1pnMG7d5w+kLDJRpVTFASs124VReo58qhIv0HGeUp04G1ITIVXq0Ku8rH1fOQxw2qYquyn0=@vger.kernel.org, AJvYcCVHsEClHJOQTZewazeA+etrATK1YgjePuX+UDWGibnqvQgMThSlEFRQhZAtgV/kNMiAXBB4X5ZCOp7jUP93@vger.kernel.org
X-Gm-Message-State: AOJu0YwiY5J8yXxKJfbku3EvWBE6dNPFH/ElnLpZe75h0DPay+YN9hNv
	uOEq9VSkIh8TAA7nEx6EuKzJZqh8xV0fHYhuJw9ZpmwYpb08dIHHjH3W28g/cLKRv+F7us5fikq
	i23RpWZTmlYlbCAnssd/T5S99Uww=
X-Gm-Gg: ASbGnctgvqusehyFv0nmiDcm0ctUa8jHBA/UM47qOrN9dh+OpuCbHguOS/iGJVw3Jvh
	yeSJgsmeOPC0shamKltwRMwpoafqLRyE4vA12q/ni0JIVgnS8jDB4UFh1X6p35m+1Y1/nwYFoLz
	QKafWi/+ejsrBOig+1TDCNxccG6Q==
X-Google-Smtp-Source: AGHT+IFULoPEpothLfwjh0swnKSIsOSLdiBNQJwOvKbn87HppFWWvrmA08t4MfTHgBorZusYx9XzpR2AijXL9kxjXtY=
X-Received: by 2002:ac2:4c49:0:b0:545:6f8:232a with SMTP id
 2adb3069b0e04-5497d38b2e6mr692464e87.13.1741218934699; Wed, 05 Mar 2025
 15:55:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206-printing_fix-v3-0-a85273b501ae@invicto.ai> <20250206-printing_fix-v3-6-a85273b501ae@invicto.ai>
In-Reply-To: <20250206-printing_fix-v3-6-a85273b501ae@invicto.ai>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 6 Mar 2025 00:55:19 +0100
X-Gm-Features: AQ5f1Jp0pj2pbUiKB4mJ1sMtL21NUUzLe-Ulw_OnHrv7vqdUo2CLF-fBvmJ5JwE
Message-ID: <CANiq72neqbD=zJ3jAizwMewxx4s2YhAvh6M-Y4sNfq9+ca3P2A@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] rust: samples: add missing newline to pr_info!
 calls in rust_print_main
To: Alban Kurti <kurti@invicto.ai>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Jonathan Corbet <corbet@lwn.net>, David Gow <davidgow@google.com>, 
	Dirk Behme <dirk.behme@de.bosch.com>, Asahi Lina <lina@asahilina.net>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Wedson Almeida Filho <walmeida@microsoft.com>, 
	"Andreas Hindborg (Samsung)" <nmi@metaspace.dk>, Tejun Heo <tj@kernel.org>, Fiona Behrens <me@kloenk.dev>, 
	Vincenzo Palazzo <vincenzopalazzodev@gmail.com>, Xiangfei Ding <dingxiangfei2009@gmail.com>, 
	rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, 
	Fox Chen <foxhlchen@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 10:08=E2=80=AFPM Alban Kurti <kurti@invicto.ai> wrot=
e:
>
> Fixes: f431c5c581fa ("samples: rust: print: Add sample code for Arc print=
ing")
> Fixes: 47cb6bf7860c ("rust: use derive(CoercePointee) on rustc >=3D 1.84.=
0")

Thanks Alban for making the effort of splitting the patch into several
and finding the right commits to tag.

I will take the first 5 patches already, but I think this last one in
particular will need to be split, because one Fixes tag points to some
LTSs and the other is very recent, so it wouldn't be backported.

Cheers,
Miguel


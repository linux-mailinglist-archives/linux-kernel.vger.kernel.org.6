Return-Path: <linux-kernel+bounces-420298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 312999D7878
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 23:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B44F91631DF
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 22:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8B317DFF1;
	Sun, 24 Nov 2024 22:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SC8H2G8h"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB4817557C
	for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 22:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732486252; cv=none; b=NKBA9pbBTDy5qGyvdbdnT4eGngiT746yEJ03WKB11/ZQaGSXbGwzLwO9QPOn1GnMVx17x2dfcbAgQgJ5hSgFZA3jZRbrW0XCp1tHZNxKgMUabC+iI2va7IfPjsct/1lBaSSsC6KQHtjV0ib2uIaYtcoBjoSOYK334AP2RZDGXW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732486252; c=relaxed/simple;
	bh=ar6ihNUcFRCpnCKKIRY6+U2tgcXR92DIV5BH0jFQKIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zngn1BJHm0TJbMz64sKY/aH+Kd2895dy9CrcpUAPXsqkbOt5cGgNixjtMQQq2mUyWkfRi4vtUcTOn0YX3SIAlNQVk36sLAGtJRYWgOgHFfTWXcFOFrtjwDhGroct9WjiDeCdxYykjI8ijjpom25hz544FXXvoGMiyQR1Upe8Dw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SC8H2G8h; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5ceb03aadb1so5228405a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 14:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732486248; x=1733091048; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=beVYaMmi0kkfaJKysIZgs/e3pXIwB76xz9Hg+r2NEqw=;
        b=SC8H2G8hvvFehr0vKYinJ8EPGYSgsuxAoPSbXXWOeWuA49JpyneGRWG5eyGKXwd8hE
         2+0OtILikJQjUNmlWYBUzn1fNMSwwzeQosRkNktGyRGq/K98FUnwvofq9WGMea5NCugH
         g0XfE08fYLFQYAkdyNQ2/rzHugYSBIufDSvcY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732486248; x=1733091048;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=beVYaMmi0kkfaJKysIZgs/e3pXIwB76xz9Hg+r2NEqw=;
        b=joxKvgROl0tvFTH1jdj9Pa4ycZpn3L97dScfeFcV/hslAe48ctwEKRDROokQUnZ/5P
         +N4wDiqn0CZVhDQg6cpUpDQ1G9yMwFzj43kYjchDVHNq3g1JUKfDDDvrVPGF7+BqvxZU
         HHt6ca+abaguKyvc3FywpAUg/oqVJXIX8bHLI7yby590jSFBjZr5+Xsf7jIrcfGvctx4
         N5VJHnS8j8nhvtF7uVYEQ73YPc9ACeeaoCXcwNZLXlTS6NGUznQT6+JJaMuaaIleAKis
         t2Q4Ajh7KnAMPoVaYZ4uOlWnwgPufdsvic0vDjs0HQqpVoN05MRvZNdEf2AbU1oerw/Z
         FlCg==
X-Forwarded-Encrypted: i=1; AJvYcCWL+n0YvUQMS6xODjNBCdXFEhZdQNfIL8V7BA0y5LfO+78Da5KcG3MxB+7yi3CKQK8g+mBW0qT0eXWikFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpSZfrVN7/vS0SACdqiQi3Ys0bn8SzyiPZYESECJ7qyL/8PKwR
	PtNf0KuZEZkqTgTOcHMZKdr19BZ3WB2XdXcPHI0uS7hkuXcUeRMu4SYtVX712aIW4NH6pOKo29n
	iWhmwmQ==
X-Gm-Gg: ASbGncti4wE+rSY49fRS/kj7Mcxgxp8ifbVBlmI0GnDLvjgaVtfpxdR/LxwIsvKJu1Q
	7cQadqSqeLdaXxUlkDQVXbEs44a+k33dk4zXj6Sb7pAoHZ+GZ4TJYYzpU5sPTpUHgaTJOFH1KdK
	dyYStbnKmyN09lDG7+Zxg9oJs6XezStNhOJApw4jwQmqlkCBCdtajT7fyhLVIQQFahFSw3ZsQAU
	K6OAl+FgHa6GGTqPGdf+1hnjKslXS8wvPPkUO6c6KTa12ScyhXEQYui/EKcIrRvT2ger+ViAUKc
	6B8gy/WT4+3+6lHkvrLXqVj9
X-Google-Smtp-Source: AGHT+IHolGS/mXzh93/Ph8PWP8YObcTU2iZ+UpluGoj5qR2v+3W1t4YrqrQR7kInl818tkh5AOHRqw==
X-Received: by 2002:a17:907:2718:b0:a99:c075:6592 with SMTP id a640c23a62f3a-aa509c0d6dbmr997353966b.56.1732486248039;
        Sun, 24 Nov 2024 14:10:48 -0800 (PST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b52fe71sm388168666b.110.2024.11.24.14.10.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Nov 2024 14:10:47 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aa5366d3b47so165924466b.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 14:10:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVNga4LZmIU6yK8A9vA0mG1REtVU0yKlSXn/r5RlkjxkITDXH6pQXDkGE6ZfQNYtU5bsH0cQ5Lkm1kGF/g=@vger.kernel.org
X-Received: by 2002:a17:906:3194:b0:aa5:274b:60ee with SMTP id
 a640c23a62f3a-aa5274b69famr809208366b.39.1732486246942; Sun, 24 Nov 2024
 14:10:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <61292055a11a3f80e3afd2ef6871416e3963b977.camel@kernel.org>
 <20241124094253.565643-1-zhenghaoran@buaa.edu.cn> <20241124174435.GB620578@frogsfrogsfrogs>
 <wxwj3mxb7xromjvy3vreqbme7tugvi7gfriyhtcznukiladeoj@o7drq3kvflfa> <20241124215014.GA3387508@ZenIV>
In-Reply-To: <20241124215014.GA3387508@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 24 Nov 2024 14:10:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=whYakCL3tws54vLjejwU3WvYVKVSpO1waXxA-vt72Kt5Q@mail.gmail.com>
Message-ID: <CAHk-=whYakCL3tws54vLjejwU3WvYVKVSpO1waXxA-vt72Kt5Q@mail.gmail.com>
Subject: Re: [RFC] metadata updates vs. fetches (was Re: [PATCH v4] fs: Fix
 data race in inode_set_ctime_to_ts)
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Mateusz Guzik <mjguzik@gmail.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	Hao-ran Zheng <zhenghaoran@buaa.edu.cn>, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, 21371365@buaa.edu.cn
Content-Type: text/plain; charset="UTF-8"

On Sun, 24 Nov 2024 at 13:50, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Linus, do you see any good reasons to bother with that kind of stuff?
> It's not the first time such metadata update vs. read atomicity comes
> up, maybe we ought to settle that for good and document the decision
> and reasons for it.
>
> This time it's about timestamp (seconds vs. nanoseconds), but there'd
> been mode vs. uid vs. gid mentioned in earlier threads.

I think the only one we ended up really caring about was i_size, which
had the 32-bit tearing problem and we do i_size_read() as a result.

I *do* think that we could perhaps extend (and rename) the
inode->i_size_seqcount to just cover all of the core inode metadata
stuff.

And then - exactly like we already do in practice with
inode->i_size_seqcount - some places might just choose to ignore it
anyway.

But at least using a sequence count shouldn't make things like stat()
any worse in practice.

That said, I don't think this is a real problem in practice. The race
window is too small, and the race effects are too insignificant.

Yes, getting the nanoseconds out of sync with the seconds is a bug,
but when it effectively never happens, and when it *does* happen it
likely has no real downsides, I suspect it's also not something we
should worry over-much about.

So I mention the "rename and extend i_size_seqcount" as a solution
that I suspect might be acceptable if somebody has the motivation and
energy, but honestly I also think "nobody can be bothered" is
acceptable in practice.

              Linus


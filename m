Return-Path: <linux-kernel+bounces-169181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB5D8BC486
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 00:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09CDCB214D9
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 22:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A825F137740;
	Sun,  5 May 2024 22:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ss7d2scn"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1FE7EF0F;
	Sun,  5 May 2024 22:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714948201; cv=none; b=W1BHjA/XtJodSGN2MXQhNZAtD5esJ0UomChD8PuqWDM3JNCn7goOxMeEEC53xpp3uZSOM9vTNFRGi15vMEyGhuv3mvtW0iIowt/5DA/uKQye3LgX5zSuw3NZN6ms31iPPXjEVls9vzLbBAgf89IYN3Noqxm4+c7orqwnlftaaCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714948201; c=relaxed/simple;
	bh=5xWlEfsfFFDZph44wbupuSRukevvKnNBayoCN3V19Zs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SNEg1kgn+omaTz2iga1ZGSEBCjHGo0DJLgju2WeHV3A6yxL409vJlEQYc7wMrDxf56/RSc6eILd5RlShM6MumcumFDlGMqVMSs+xshAKot9VvqXnw7CbDYGth47wSuqhvu1/P7IO+y3eLNvCh0SYHOnn+8qF4hnCfDGG3fTkxjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ss7d2scn; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3c7513a991cso1076061b6e.1;
        Sun, 05 May 2024 15:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714948199; x=1715552999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fnwxKudmox0Z7beb0U1kkwda4gN0K4skeLrb2kRmeoc=;
        b=Ss7d2scnWl8odJiBtBhpo/gqi9XHlAi06ysr+LJfpuq/ETROpqVBilvJwknCtkXw7L
         JH7fyDzB50Stevq2uJNdbVYH1b3lZ5+3dlZCXiDg0O7Kcslvy/1Kthq763a2ZkeXA8Kg
         5SPFFU/gFlphVfCQ5OaGvziA8j+WRkhOmKaxRtFpZG+vyAUXTx6wX9QdB5Lu/MZ2J2Ph
         AUf95ys+5vqtWeBZXz6y97egFQzJf0qHASFGs9pE0jmIHarWC6y/Y1MVRhBOpVJe4oDC
         6M0akNoZNbCyYCHA0T6TzE2OS50cLjxrUHjiP8Dg+Xoo+QkqHTXwG0lXoJWUjFUFxj0X
         na0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714948199; x=1715552999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fnwxKudmox0Z7beb0U1kkwda4gN0K4skeLrb2kRmeoc=;
        b=Dm2LW4nYYJw7MQr5dIBGpAhbTuMcRUfQGDUzwntQg8dn7yGWSabbvzebaJl52Gy0Df
         VrVQR2WqUI86vRl90xx1VEk4f54VwoJo6DlfzkBw6lM7wfejHsmE7H3U80oniOggBNso
         L5CN/wLiDe5reVRNcCdrm2iC4sWeLxdaLKSn/yOsVwV7bqb2Wg32xMt7PU84mNa/IOlF
         xoK+RNUMqQ10/PiWYVxHskMDCm24/vvf1pPVKN5yWiAyMxQw0yzUFsUZULY2vXxkCgle
         Bhtg+T/r2y3KiaaQmxImdOmjEe8BpX0SnJ641dDBJpOAUQedjUxdXl24X6RgazyyxgyO
         pXPw==
X-Forwarded-Encrypted: i=1; AJvYcCUgBh+FroPA1A2zM6yIoqr2upo7nzGiHNPuGn19N4fgW1EZI/U1P45qWGueZGKfwLfou4RWkDZj+GLxHYCUYfGpZ5ao+kqUsZ7NPjGqGiDz+eLon0bs8qO1HGzIwxYsAHQCK8KK/tSiOcp1QFk=
X-Gm-Message-State: AOJu0YwXkRcTvTAoVJsHe9nBXMMkLn12Q9tlXTWkpO6icp/SGLZovGgL
	HvGayG7xIRCV6X+vQcE/QucdgY6xVcq/1ImMcbPC6gULC08BqmPqaLBhC2+ZOD3S0FRklvJGpYf
	kh/hIbDxeQpP32tfzkwvslnOr0NU=
X-Google-Smtp-Source: AGHT+IF8aQhOptcBwHFDnQiYiFDTGDXVbsmmJnITpceh99MDRz6tqNrg8kvc4JPlex+GXX4nVzqb3+8pER/BD0QWeek=
X-Received: by 2002:a05:6358:2181:b0:183:7d27:c08d with SMTP id
 v1-20020a056358218100b001837d27c08dmr13774060rwb.32.1714948198723; Sun, 05
 May 2024 15:29:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <eba70259-9b10-4bf7-ac4f-d7accf6b8891@smtp-relay.sendinblue.com>
In-Reply-To: <eba70259-9b10-4bf7-ac4f-d7accf6b8891@smtp-relay.sendinblue.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 6 May 2024 00:28:35 +0200
Message-ID: <CANiq72=+iRTiL5Aisvq9Bea4FegF5CmHCLjn9AYPormgtwb62g@mail.gmail.com>
Subject: Re: [PATCH] rust: update `dbg!()` to format column number
To: dev@raxyte.com
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, aliceryhl@google.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 14, 2024 at 3:21=E2=80=AFPM <dev@raxyte.com> wrote:
>
> In Rust 1.76.0, the `dbg!()` macro was updated to also format the column
> number. The reason cited was usage of a few characters worth of
> horizontal space while allowing direct jumps to the source location. [1]
>
> Link: https://github.com/rust-lang/rust/pull/114962 [1]
> Link: https://github.com/Rust-for-Linux/linux/issues/1065
>
> Signed-off-by: Raghav Narang <dev@raxyte.com>

The commit author was:

    dev@raxyte.com <dev@raxyte.com>

and I fixed it to:

    Raghav Narang <dev@raxyte.com>

i.e. with the name from the Signed-off-by line. If this is not
correct, please let me know!

[ Fixed commit author name and removed spurious newline in message. - Migue=
l ]

Applied to `rust-next` -- thanks everyone!

Cheers,
Miguel


Return-Path: <linux-kernel+bounces-417235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A919D5104
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 17:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A635EB23AAA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 16:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CC5197A87;
	Thu, 21 Nov 2024 16:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jt6b54Rx"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4471110A3E;
	Thu, 21 Nov 2024 16:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732208092; cv=none; b=euCeP7jzOilX6Qj0Z6QDGF9AR/F689yUjiUjVH4+IF5ZknJjyYu2B4yPMeD85ZxJS4oiKUUFpK4jw23LR1OL4b3iLjyFgmD/a+7MRkSbVGYtuJr98a05p0U63n45WuU4kr77lPrOlAcI/WXIC2pXXjlQderuKeXsKrng0S8p0HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732208092; c=relaxed/simple;
	bh=M8rNJXhf44ujjUl3m6ZS4/RxCfo6THGjZNm7kZcTtos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GUCAiwrHXyW6spk0UWBvGkLmP2flPU7ZJw5JT9OdacVSCrYO+a1Yf78mlro8Qhwmf8U5ZbxCDmwcodTbanIQjQyq8H3x/9b6E6cQki6aOwBKQhkaCbDmsqoGv1cS436y5Gd83RFsLNjvnN5xXiM8Mh5oc72yE4NGppzhVTSsa1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jt6b54Rx; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ea4e9e6ef2so975712a91.1;
        Thu, 21 Nov 2024 08:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732208090; x=1732812890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M8rNJXhf44ujjUl3m6ZS4/RxCfo6THGjZNm7kZcTtos=;
        b=Jt6b54RxhZBD7SX7Ubll/RbtslR/n1+aefmVMaQkwGrgOJ/DQPa2YhPur+H/ILX7kv
         4Y6b94AvZAyPXXx/HG2BgVR7lax3rnAQT9xtc/nKbi6+03G+yOObyfCFkhHvI/SmoBhB
         nY8ptVXDd6FY671TgO8jTxMTnEjD/Hz/aECIOSp0VBmRAGHApRIn0QEJaz6Rw+8rgFF3
         dat0Ru7RwxPTVaB7Zcwu8dvMZ6HcTeMZ7qEcwl0n/lwdk2WJtKeNa74wWRIEkIjLaI7l
         oKhuUynOukG/HxZ5PCFHZibVsmXVKoQnVy8fzBKjAmWPRrJlqXZ2pLRwiN76VGHAE9a9
         /yBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732208090; x=1732812890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M8rNJXhf44ujjUl3m6ZS4/RxCfo6THGjZNm7kZcTtos=;
        b=gRetJODAebEcyq0sMz+sAUOsYZ4YM6whDAu/plIDmKf15/U4o/Kt2mlH64k7q9N/oA
         IjHAmdq7zrWrFAeWxKShnZEWe1/MnScfbvkip1eotZ88QIDg9na52jW/FOc1NcPzZbtb
         ugBAj9jmbJ0q0OB+CJJPsP+V+FSaGLkPY7rQx22b9kdLx0v2Afm5/tpwCg1CWPLADfvZ
         FS2Ak6aWtXp4uWjmDrd35TzLbfHERe2B5nc0JHmo/9czoJ3XCmjzXtnVxC6iqYlo7nW1
         r9XynitN57cyab2HkEKL6GRkOIVzb3sbhzPIa9sl/c5XiNj6i3eDWAe+Bn4fIlBl+pX5
         RXZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZutZAFcZGZ40X4PddtDDGRmO8C2XtC09Dgrl7zIRfUpjRWQvLkYoOMRuB9Gqy/U8Dinsuv0OhroDnHcOE/XQ=@vger.kernel.org, AJvYcCXUDFpVUZCnFqZ0Sf86Q9XJrYMonmxVL6GmeuyEVIleKNlQ4xxgtHhauD6Hqas4RYhsYU6T8Ekyb7y3vHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YycLf0R/5yBJnXuyJexFBiiI0r9Tfk4V4RJjLsRl2JtdmN24lWL
	3/DZzmgbhTmZPbImMUoyZfoWfNwRyM5X1lEvVcpe0OLzfBBPiaLZX9MAF4juGWw8gcl8GRgGA4q
	YtTLL9nRkIBTCyHZ0Y+pFEZRFAJM=
X-Gm-Gg: ASbGncue285ZxWC6vRhPKspu3Aa/bqKs14RzfZZ5kb8AI1kpLpGKx50qSECSnVXD1mE
	h7jGetWyrHW/cwSEtaWRHyFlgfLc=
X-Google-Smtp-Source: AGHT+IFyqooLT2p74ty7CWtuRotWSHV7C7bXhM5HmHFNy5Hykzc+Rza8C0r/1teEORhHYNFTCYnnxVhL2getrYolrYg=
X-Received: by 2002:a17:90b:1b0b:b0:2ea:97b6:c44d with SMTP id
 98e67ed59e1d1-2eaca703c19mr9898767a91.15.1732208090332; Thu, 21 Nov 2024
 08:54:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1728818976.git.hridesh699@gmail.com> <32382c55dbcb6482d6e686d541c2e15b282908cd.1728818976.git.hridesh699@gmail.com>
 <CALiyAo==Bk1qjVcnQKc+0YUOzgKuYSvJts+eNrMDx+E3XxMsGw@mail.gmail.com> <CANiq72noG77qLF1WcRu4qJNboyqs9Xvvu_ZmjVN8qitK_MNWnw@mail.gmail.com>
In-Reply-To: <CANiq72noG77qLF1WcRu4qJNboyqs9Xvvu_ZmjVN8qitK_MNWnw@mail.gmail.com>
From: Hridesh MG <hridesh699@gmail.com>
Date: Thu, 21 Nov 2024 22:24:12 +0530
Message-ID: <CALiyAonkPe7TR+uofOAER9e0nsYL0xq_q_jfeTfwSv9j=L+LTQ@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] checkpatch: warn on empty rust doc comments
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Dwaipayan Ray <dwaipayanray1@gmail.com>, 
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
	Wedson Almeida Filho <walmeida@microsoft.com>, Valentin Obst <kernel@valentinobst.de>, 
	Patrick Miller <paddymills@proton.me>, Alex Mantel <alexmantel93@mailbox.org>, 
	Matt Gilbride <mattgilbride@google.com>, Aswin Unnikrishnan <aswinunni01@gmail.com>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Apologies for the repeated pings, but I=E2=80=99d greatly appreciate it if
someone could help move this forward


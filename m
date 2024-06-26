Return-Path: <linux-kernel+bounces-231633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6278E919B0A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 01:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F3D12842A6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 23:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6FD1940B5;
	Wed, 26 Jun 2024 23:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cUB3AAmf"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6B117F500;
	Wed, 26 Jun 2024 23:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719443331; cv=none; b=UaqlHMPAe4bAWCMAV+92wV4WkBtQ3AQMvKplTom8IEwXDjrcCcQhoPKjHHQ7NkAGUXqNcTWW82xYArAJMI4/cbV+nLm22gKA9UXnjPx4+Xlf+giNWPp13zYdw1GHL8oUG7JoqP3m1cJNBYszOIrBqTn2iGpb21lFtEG5slJFT/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719443331; c=relaxed/simple;
	bh=XttEmu+mRYXZoOSAExgXXBGNXMhJYkQq60EN3tyDTM8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=eRhX9GOSPaTk5/4SJh5OgArSkKL6XH1dGrDp0pi5KcLNHfX6N86MOeyuZeWL0iuugbvX/9/F4lJd8E9YKSoCSjVli6J/wyhN0eNpZNltx8Npzzir5fprXVZnMrz4Z2uZ/A2RvUNwsqseVlQve+3YjpKkowiLqtL2q1SrxBzW/os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cUB3AAmf; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7eec09cc7f6so293206939f.0;
        Wed, 26 Jun 2024 16:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719443329; x=1720048129; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XttEmu+mRYXZoOSAExgXXBGNXMhJYkQq60EN3tyDTM8=;
        b=cUB3AAmfz5ZKJtvZGwiFQvAmtp523KaVws+IpMYUFl6EVtzK5ZbNeSKov3neSoDgAa
         JOtlH0fzm7ergI+ZcHojLXvE0V0ZMbhxdWL06G9/Wggxu1Yyxfku5OFwYhYiK7aZfAhe
         zgMmMIDYyNv9SFyhKXMJDPk2VMuh48apbWfXBphqvoqfz630CD/LrdRDPK4p8RMDY51v
         cm/8geP0PabRcj5bymuX4e+kKPmMHYeBfodBHVpXxhjoZOYpdxoSBfqROrj32hrsCdIp
         J7sJ9EKpfBiI/RGiO3tytUI2kuWG4EuwGhqSXw2tb15VU2QU1AslHofLFRtyjfMII5nt
         HRJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719443329; x=1720048129;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XttEmu+mRYXZoOSAExgXXBGNXMhJYkQq60EN3tyDTM8=;
        b=gFhJ8iqC47R2yv80ptITBXkqvS/s19Y9jjLCcg4qmyT3fHmBihe4uFJTKs+hLUPhqY
         kTNlBgExEyG1SyPhqLru31q3PeFIzFKK6jnA4XN2+qQabLIe2dCNUVaEX31jY1IuhMLE
         ADPxPx9yeh/tIJSiSLx/rLsnJCinkpsuwUwoeB7+K2Mp3mRl/c/I4LSXi+SGMgowHjsS
         4Dpjpn2KaBW9spXQlqQa1RbcV5JehD2pJaRZi5XyJE3pvBzCou3i9oHUm4FReKiazo2n
         +ctu2aloF9f/HtpHs2EdqFHpWvUKpXCe7oFxVLMRbOPGML2WMffId2YFrbONAQdDoyo+
         d1nQ==
X-Forwarded-Encrypted: i=1; AJvYcCVV1RxU9CR0ztgruA3YA/RaeFVF+Ix/XTEGGPzZWj5xUf/VtqYPIeA0+5Hc96JQUcRVds/VN47oWkhL1iTW47AqK/LgFsiUIZHhtWTZdWVw75K7jv0GcnDdD6a3iVKmInVz13nukKTQa586GXk=
X-Gm-Message-State: AOJu0Yy2OUpJ5QbvyCtzUbNKPQYjYOsfUROWe+CHfmGEKljrKW3Nygm1
	q4epEYfEJek4aLMe32Qj9fgx4DCRLNzEHksgP+2l+Nt4COg5+u0H
X-Google-Smtp-Source: AGHT+IF/bwZtPc1w+pfzlkRmt37Cy5RrGDawSx+LJn4vUsvGuApxlVM0WX2q9+eH0nVx4jrdCWn3LA==
X-Received: by 2002:a05:6602:6b0d:b0:7eb:6f43:a5d2 with SMTP id ca18e2360f4ac-7f3a13db1a1mr1548840639f.6.1719443329089;
        Wed, 26 Jun 2024 16:08:49 -0700 (PDT)
Received: from localhost (h135-131-130-199.ashwwi.broadband.dynamic.tds.net. [135.131.130.199])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4bb6649e552sm39182173.54.2024.06.26.16.08.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 16:08:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 26 Jun 2024 18:08:47 -0500
Message-Id: <D2ABSFPMRNP9.LYEVA0EZAD07@gmail.com>
Cc: <a.hindborg@samsung.com>, <alex.gaynor@gmail.com>,
 <aswinunni01@gmail.com>, <benno.lossin@proton.me>,
 <bjorn3_gh@protonmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <linux-kernel@vger.kernel.org>, <ojeda@kernel.org>,
 <rust-for-linux@vger.kernel.org>, <tmgross@umich.edu>,
 <wedsonaf@gmail.com>, <yakoyoku@gmail.com>
Subject: Re: [PATCH 3/4] rust: macros: Enable use from macro_rules!
From: "Ethan D. Twardy" <ethan.twardy@gmail.com>
To: "Alice Ryhl" <aliceryhl@google.com>
X-Mailer: aerc 9999
References: <20240624030327.90301-4-ethan.twardy@gmail.com>
 <20240624084331.2864993-1-aliceryhl@google.com>
In-Reply-To: <20240624084331.2864993-1-aliceryhl@google.com>

On Mon Jun 24, 2024 at 3:43 AM CDT, Alice Ryhl wrote:
> The actual change looks good to me.
>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>

Thank you!

> Normally this would be formatted as:
>
> Link: https://doc.rust-lang.org/stable/proc_macro/enum.Delimiter.html [1]
> Signed-off-by: Ethan D. Twardy <ethan.twardy@gmail.com>

Ah, thank you for informing me on this :).

> There's a non-hidden empty line between the last constant and
> `macro_rules! pub_no_prefix`. You should either hide the empty line or
> get rid of it, because it will look weird when the example is rendered.
>
>
> Another option would be to keep the import so that the empty line
> separates the import from the macro declaration.

Done! (And the one other identical one, as well).

> I would probably indent [<$prefix $newname:span>] one more time.
>
> Alice

Done, as well. As with PATCH 2/4, these will ship with v2.


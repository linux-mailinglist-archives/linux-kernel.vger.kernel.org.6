Return-Path: <linux-kernel+bounces-573014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB85A6D176
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 23:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA72716F2A9
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 22:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACE11AD3E0;
	Sun, 23 Mar 2025 22:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOEoACuq"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6C518FC9D;
	Sun, 23 Mar 2025 22:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742769128; cv=none; b=t9wb+dL64iyB1mTXmFK974T+cWPeES3SRnaLSZQih6WvX1BogRtJjQEFcwlId6rR4XcK6669QyGj4YD36gS4X49noSFMeja5T2a3Oq0O33vc0oFGY3uJeF8YULAagfq/2beOv/e5485J3YQ/m1EvJyNdG2O8hhi5Q7VDctRGOtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742769128; c=relaxed/simple;
	bh=ckiFsgnFRsndBCSUp0jyyeFBVCRJh6uCFlkCY7hHwho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WDoQnw6C8mLsHzijJeWdAJmA5h77yrwYdovb1c/phSN0mDztcDYyQtg8ybwseIEaGPxkI10fBG8/u1DG5jYdgm497eUBamNFOtYC2tva1igLJ9j/Pl8XcFeCfWGIVVbQ+Ie5tX2o+kw+hUuM9lysZJJ4jdCKWUzjgq9kWoWVBtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MOEoACuq; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-301001bc6a8so1049140a91.1;
        Sun, 23 Mar 2025 15:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742769126; x=1743373926; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qpQmANioPLvwRb3ZUWp7uoDXu2wKpVE/XtCKMWjV3HY=;
        b=MOEoACuqJRhemsZVKkpC3OV8BAUDYjidv4QXMzpl4UDrcdX9GPGJIyywMwhrz47V9m
         jMIqQb8T1IEx0UA8V9H0IQlwhRBXEvwhZM1x09UfjDoReBjdiLWfyWEOZXedd7lIJDUb
         Gpbx0HgiRRtf/MkLD694otVwWsrSat2oRXJnrva0J9MnIwheeyssiOhlwaLi9Z0/n/Ry
         T2Br0fxtDPAzffgivvVJaszfyF6VVzSs3mTeGgRDmT2KM93PbgHfXM8tZqoq9N7vo9/T
         uQKK7rdiy9IE/Gd+hX1Gc0sPIIuKh6UtxYSrOoVRnxqJ8lwFqnd1wAxbBTBtdL+bQJC9
         ghyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742769126; x=1743373926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qpQmANioPLvwRb3ZUWp7uoDXu2wKpVE/XtCKMWjV3HY=;
        b=mWqhiIfy0cHHD8zFWS8xQFJpWlHjn/yBIPgyC7NyxBuK/aR3cCC6ypq94b+ZXDQOvr
         7eVyKFUamkpJwRSnLxSeZLP8ZMu1S1gNJzkupkV3Rz7UluprdYFAUa3jhY0cxUxLpGD3
         NOj8vwxPZze52DJepJ7oJkMOLIvLXQ3f2OHo1I370Y2piZNMyQ4ho/9F5j8+3OL1sJYm
         dwapYABPbPqdeBVfZ9LWjJMM5AWXYNTNFYeC1gDerrQ9BU/AKZR593hjToJI7Tpsvaqi
         WPjhinRFtiVnW5Jo6feMe7ZzhitOXcu91NT0mKYWERA8g+DESFPpldB1Oear4BPUaLLI
         EymQ==
X-Forwarded-Encrypted: i=1; AJvYcCURp041nMYtCvIKs0eg2J1/oNA4qJU1m7q0PFjFePlvOTTWxCvOs9C2fn15R+Nh21Cwjz9LQjXgPwY9VLPvSO0=@vger.kernel.org, AJvYcCVwaq9a3mMvlDnozAUWHMBJ7ujwC4JICnLhkyRFdv5k/3XgM9WI9h/i71q1ryJpvU30tTCu+nnpsEWY7Qw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZLnVGEzvQGREdYziCguwvtNUOtaC9ftHTvyaBCivglX2p68rh
	7bf2968aVVlZ9BAXtiQgOrtozkcQqFD9qGyl/AZ4zaVp5/ZVqKh5drwDwOk7Vsqt7txn9QzA6q9
	lajY/w90mmEmfdg818geoMLGRIHo=
X-Gm-Gg: ASbGnctYHWx6QzmUEH0U++C+LfqMjWwIoStfRn0GkXhs3lYtRvLTTFUMVE5tv49JjXO
	a7XIssByjOloqQL1A8QCS+VWShsak/vCzKmvlssI4tJUQTvdQUuEow547dWSnhlJVHnBSx4b7EQ
	O17sGj7iV8/Fh33y15+AKbdKbC8w==
X-Google-Smtp-Source: AGHT+IGoYvW+9AOT9407sdZ1db01as5vEkY9PtOhh2CNc3kSweQvqagzcV4Sk489fRHFECKiV93ufdAokH+a/1PaS+g=
X-Received: by 2002:a17:903:1a23:b0:224:1001:6777 with SMTP id
 d9443c01a7336-22780c7f938mr65469125ad.4.1742769125695; Sun, 23 Mar 2025
 15:32:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317-uaccess-typo-reserve-v1-1-bbfcb45121f3@gmail.com>
In-Reply-To: <20250317-uaccess-typo-reserve-v1-1-bbfcb45121f3@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 23 Mar 2025 23:31:53 +0100
X-Gm-Features: AQ5f1JoYBxrfDvizw0dfXIBUvPU5PO_SHXCaIZc2uNUkRdDTxqWtAZpkbSiSTuM
Message-ID: <CANiq72nJRbh6HZgKSUY2cibOvSd3UaBqYoKZQhX8+hBCPMo1ag@mail.gmail.com>
Subject: Re: [PATCH] rust: uaccess: name the correct function
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Wedson Almeida Filho <wedsonaf@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 12:43=E2=80=AFPM Tamir Duberstein <tamird@gmail.com=
> wrote:
>
> Correctly refer to `reserve` rather than `try_reserve` in a comment.  Thi=
s
> comment has been incorrect since inception in commit 1b580e7b9ba2 ("rust:
> uaccess: add userspace pointers").
>
> Fixes: 1b580e7b9ba2 ("rust: uaccess: add userspace pointers")
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Applied to `rust-next` -- thanks everyone!

Cheers,
Miguel


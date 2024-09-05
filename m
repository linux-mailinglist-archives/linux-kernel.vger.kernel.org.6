Return-Path: <linux-kernel+bounces-316545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F06196D10A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 09:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FD911C22EAD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 07:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31E91953BD;
	Thu,  5 Sep 2024 07:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="biNdxn/R"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79D11946C3
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 07:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725523071; cv=none; b=T6ghX5deRCPrH/ieuVYiiQ/2dLqthMUgfcQ37j4sYn4NBp0iFmw+6mEMhPYh+u6rUKYGjbJVQdFfhvKpILaw7A1qPej/lR1RiN31drwpKu8xRnzZlsmaiDhPxttaErOKvHbPV52N/WLtc0he0Kywb/buNdT6I61srcpULt0Zhd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725523071; c=relaxed/simple;
	bh=uzqoXNG3+qdG4fZg0Gqs2RhJ7NCXI4GO3eiiknmlaNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C60XQgAYe5iCDlq3TaOSqOylIsTlXJb3utB/N9fjTBp5a3pg71HKF3GfrjNCLlfvGY8345EmBFh7qHTDh5zIc6fA4IX87tfFhOJ093F6y+XvQ8R+Yqe82ZGbxAj/7RnrKACKKqMh4LqbWnw284py/bc8H3y+SFqRR0KG68f2QCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=biNdxn/R; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-374c6187b6eso263862f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 00:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725523068; x=1726127868; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uzqoXNG3+qdG4fZg0Gqs2RhJ7NCXI4GO3eiiknmlaNE=;
        b=biNdxn/RMiYcU5zUJyf9c3MiMf2rWAX0GkmH0Ug2zdW/mJKPq+8Yckt+pmiPv+CINF
         oGbD34Xi7YsCzzWE23y0Z7F+juwg6/n7MdTnVR3GQ7zCd/UFK4MFNwgPHy0qYh5+vpK5
         Yt5QKpNoO/B8kH6Y2DXyX31zsGjyg0W64evJh3X5SUOo7mQb5gZUvuIyuabPhUOKoOeg
         6Fd6f/9J8Hl6qyaQOtIDyyPAU4/7XYqBQMFLHHIsW+Xfw8fa/FlrGpAG5RRkoDW0PNcg
         GIcOXPNT9AK8n9+Su9NID2j2OWB57SSAqJY8LoUGCT1ZfplbFNzomp3JipripIbqUsMN
         DLyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725523068; x=1726127868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uzqoXNG3+qdG4fZg0Gqs2RhJ7NCXI4GO3eiiknmlaNE=;
        b=KHF/Tzn8LDrCkewbOFnCOqGvkPtcgyLKVAD5Blh4hdeozNEq1rWrHKvt8Ea7zA4A6V
         VyjBZOCnE2Bu+5YDdEOiQH0UU9yDj/FSlj5IXDzVRkAjAAcWzSs4PpSHqjHfSRFMvLFi
         oDBIszn+Kgk29bljB6K44v46NYCBBJvzamrlVA3WSBYNdS0jErPteeyn7IwzsPPUo1cS
         7ZMnGbo+lokvCfGZXTLkEj9DBpqmFAFEPL63fc6uYExg2L8dzXAqCm8USbDrWkN4g6kd
         CUxMUzb2QKJ8UgHKrTY8Scy2ef+vM5UdjrpkaoDCkqoeTBfNzZc87O4KbgcuHM5TQp0y
         YBIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPRyThGCGXNt/on+o77+FwhvRpsVJ/uFTROTCiV7fZrmOU41szDxJwV7hDPKhxoaEjGEuFq8w9JUfTtAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmsV0XEvleUtX2+M1qQJ3uO0pp16O8Athga/bZJj4ELpwwF4sg
	SImJeBtx+WF6JemYmcmnRmgb6noZNXdoyiS/g3/DPGKKNrWoUz9Vtc4fLLswqLeu/t9U0o4GP3o
	xOCnOGmIxKEYPY0E3iVyEhskmmivihBjMYc/9
X-Google-Smtp-Source: AGHT+IHTjzNnIL5A1Fd+8dZPOcunE+C0lDt4qQ8dgmGxe28nKfdYYnM8VoMndW494oUXHykAwYo0jir5Q6p0G0T9D5E=
X-Received: by 2002:a05:6000:4013:b0:374:c621:62a6 with SMTP id
 ffacd0b85a97d-374c62164damr10875495f8f.47.1725523067641; Thu, 05 Sep 2024
 00:57:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904204347.168520-1-ojeda@kernel.org> <20240904204347.168520-3-ojeda@kernel.org>
In-Reply-To: <20240904204347.168520-3-ojeda@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 5 Sep 2024 09:57:35 +0200
Message-ID: <CAH5fLgjte9RYaRMHeKfRpefPBkXuSYp8FnCq=9Ftr9eV+V3S2Q@mail.gmail.com>
Subject: Re: [PATCH 02/19] rust: sort global Rust flags
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 10:44=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Sort the global Rust flags so that it is easier to follow along when we
> have more, like this patch series does.
>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>


Return-Path: <linux-kernel+bounces-386319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1089B41ED
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 06:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DE081C21B02
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 05:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDE4201008;
	Tue, 29 Oct 2024 05:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O4MXc1dw"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD07201005
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 05:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730181098; cv=none; b=BURVzkpI/G4ZAY4bdNDw082JPbVRDD/Qwdm1bIlXekiZ06bL4vFi251gPPhihREt/IP7r06hjeFGKQW/zP352pJ+GM7cD5qCdRyryUvnUA9BSpzA7peBQ3iwV25DcmBnL936kJVylC3GzLnfQbTfhlYyq/jOxam9UqxwS8GIxkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730181098; c=relaxed/simple;
	bh=rkJGzaJiGDNyDHmrzD6Ukn0kvrLRqUNFw7rsJbF66DM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CbUyWXwQHGQzbdTAXXTD5iyV5y5Smi1G4J8n5FPooxeK+P4C7fbYDKOTAOiTlb4httOZSgBCre/e+syOizFnonjT/it1Ogrg2sTEEQ6881VT1fRXzlaRDQDWkKCZl6KTqvcRFHCwnP7dDplrqn1STVUaZMegt/x5c3veFs+dD4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O4MXc1dw; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-460969c49f2so146861cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 22:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730181095; x=1730785895; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yS+AWBnCO/J18Xc6TcuxqR5XEdAGr/Rpio3YV4nA0AE=;
        b=O4MXc1dwxcgbsQWGK53emGves46j/aC/NBO5mU8uxHNFbMgm99YV1mCvYt9FMmNEza
         Nrd0l09XgIndpa3N3+rrO40GWHE8PMH7DSRn3APfxUKc4+e+mpNPr5krVYfDQMYaBz23
         nH1KKMPj/U8SaZ35spcPGvPCabb5tlab7e/+5XDtZbEyF3Vt2zbgaTjPJRaLBEgdjAW8
         aOkTwCEQ+Zcgy00U/n839uEzdgcCnE5gwi3sacJIgOnnSCbV2+TP+4lRbRS1z4BLEBFu
         y1KDxn2N4Xlmsy+XhzHUd8ZpFcdvQNNezNsYWFO3DJcGqSuqYguNEDUe50pXcQrHwjMI
         zJqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730181095; x=1730785895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yS+AWBnCO/J18Xc6TcuxqR5XEdAGr/Rpio3YV4nA0AE=;
        b=Hgd/oV1494/agNHk3lkm66wm8b5VIbIBCkUEdS27anqsM+qLEpcal/1lLpBM1lcsXy
         bpf7NIh4TKxB02CdiRzgrHh/lsC2tSK+EjKhVJ6YlAHJv2h2hz1N5a/EM9Ndd1IaLMyv
         e4SDtrdasQJCPilsAB7x8Rc10JKko2x4un/pF1dhDQFqpqQzsTY5TKCn68pi2/EUete2
         42Egtf9B9n8A+TFkyFeohrT8BpBaEGhIuHxn981X+bHk5RdHe69uVCUtioLCQQrAlY5g
         +VqHkvHeGLfp4PeEz9i6AJXo4kRCImt15d2v8B9aEoeOihpqq4DNfQtWfJXmIii8ncyP
         yQNA==
X-Forwarded-Encrypted: i=1; AJvYcCWvZOizWkD/P7F7u5suLkzoJUQE45EL6b4WnU75G8n7YFtI0XGzDUd9HCs/6CckfA+2atju9cW6CC7mWDI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu7tV1JL573hGa61xNOA6rn5ei4DIFUFSd1txY1gtcws05DIAf
	YgpBMu9/HUDr5sthQXe8tiGqByacFQPGxoeDAICiISNo8lqP2WeJDjHiuZEq5UKPNYEVVq0wa8y
	E1qtxDdIaQOSXQS0ppjlg7b0zbqHFNiwxSvIo
X-Gm-Gg: ASbGncu34Y+2IIKpNLJy0o16q7RNjrBNFYrUcrW/SEh7wlVCjwJNxu1//7Q36+HELRD
	Wk/nZxxekKj+sr5ZlAe7aJ8YXSlfOhjjfxWQPJfY6Fdgd5i7lqb8y8QJS594=
X-Google-Smtp-Source: AGHT+IEVAXdFG3fNtFOsbcJBNRZwq6dZ7NPHf4Fl17QtrnIba/Ad0eOq8gq9bIFuScwN6QgnbyAorRomVIE9wKpqH3w=
X-Received: by 2002:a05:622a:38b:b0:45f:6f3:5671 with SMTP id
 d75a77b69052e-46164fa2de0mr2424301cf.20.1730181094473; Mon, 28 Oct 2024
 22:51:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241026051410.2819338-1-xur@google.com> <20241026051410.2819338-3-xur@google.com>
 <202410281716.0C8F383@keescook> <0605fa9c-0e48-48ec-b04d-c2ef1c48fdd9@zytor.com>
In-Reply-To: <0605fa9c-0e48-48ec-b04d-c2ef1c48fdd9@zytor.com>
From: Rong Xu <xur@google.com>
Date: Mon, 28 Oct 2024 22:51:21 -0700
Message-ID: <CAF1bQ=QDQ+ACsH2CchnRk2LDRpN_WYjJOAjr9FDspxiar+YbrQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/7] objtool: Fix unreachable instruction warnings for
 weak functions
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Kees Cook <kees@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Bill Wendling <morbo@google.com>, Borislav Petkov <bp@alien8.de>, Breno Leitao <leitao@debian.org>, 
	Brian Gerst <brgerst@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	David Li <davidxl@google.com>, Han Shen <shenhan@google.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Poimboeuf <jpoimboe@kernel.org>, Juergen Gross <jgross@suse.com>, 
	Justin Stitt <justinstitt@google.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	"Mike Rapoport (IBM)" <rppt@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Nicolas Schier <nicolas@fjasle.eu>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Wei Yang <richard.weiyang@gmail.com>, workflows@vger.kernel.org, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Maksim Panchenko <max4bolt@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Yabin Cui <yabinc@google.com>, 
	Krzysztof Pszeniczny <kpszeniczny@google.com>, Sriraman Tallam <tmsriram@google.com>, 
	Stephane Eranian <eranian@google.com>, x86@kernel.org, linux-arch@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I think the objtool works on individual object files (or vmlinux.o).
The -Wl,--gc-sections flag, on the other hand, is a linker flag that
acts on the final link -- it's applied after objtool invocations.
Therefore, even with -Wl,--gc-sections, we'll still encounter those
spurious warnings from objtool.

-Rong

On Mon, Oct 28, 2024 at 5:19=E2=80=AFPM H. Peter Anvin <hpa@zytor.com> wrot=
e:
>
> On 10/28/24 17:16, Kees Cook wrote:
> > On Fri, Oct 25, 2024 at 10:14:04PM -0700, Rong Xu wrote:
> >> In the presence of both weak and strong function definitions, the
> >> linker drops the weak symbol in favor of a strong symbol, but
> >> leaves the code in place. Code in ignore_unreachable_insn() has
> >> some heuristics to suppress the warning, but it does not work when
> >> -ffunction-sections is enabled.
> >>
> >> Suppose function foo has both strong and weak definitions.
> >> Case 1: The strong definition has an annotated section name,
> >> like .init.text. Only the weak definition will be placed into
> >> .text.foo. But since the section has no symbols, there will be no
> >> "hole" in the section.
> >>
> >> Case 2: Both sections are without an annotated section name.
> >> Both will be placed into .text.foo section, but there will be only one
> >> symbol (the strong one). If the weak code is before the strong code,
> >> there is no "hole" as it fails to find the right-most symbol before
> >> the offset.
> >>
> >> The fix is to use the first node to compute the hole if hole.sym
> >> is empty. If there is no symbol in the section, the first node
> >> will be NULL, in which case, -1 is returned to skip the whole
> >> section.
> >>
> >> Co-developed-by: Han Shen <shenhan@google.com>
> >> Signed-off-by: Han Shen <shenhan@google.com>
> >
> > This seems logically correct to me, but I'd love to see review from Jos=
h
> > and/or Peter Z on this change too.
> >
> > Reviewed-by: Kees Cook <kees@kernel.org>
> >
>
> Does this happen even with -Wl,--gc-sections?
>
>         -hpa
>


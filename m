Return-Path: <linux-kernel+bounces-366034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4654999EFEC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 16:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 556AB1C20DBD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 14:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4530B1D515D;
	Tue, 15 Oct 2024 14:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jshjfl8H"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152A41C4A2F
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 14:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729003442; cv=none; b=ba34Sjjdso9iXCIA/qgsKMgoibrdTqfmIZ3ps3iMn/PHWFGX9FXgSulcD0JmX2JcyKm5U61CfpOWfldir9UocKLuJvOz4EpAjozP3PkW/pYJxSH8axq1/PYZAlY9iftYDIzrAalrlWEn/t84o8sY9htiwdBZRy2Z+ijZ+31Gzuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729003442; c=relaxed/simple;
	bh=3lpMQC/f5DBAD5or9lbKKrPkKemScfy3OJSYurxvJuw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hFVG13qCM0UqTWgketSeGOYOFjmwS2uFDrsUyCn4e3krHPSVPAwa8i+qavavGpp68JD5YdBSxMD9hzdAx6T+q9Sv6UJkP9Ezabh4Xm/0qoS3OSD2ejzwgAvd0wXuU/ZSogqVLTv2U2C9QJBTBp4MpVqhNVmU3Q/TGMvfPNTjy+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jshjfl8H; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c934b2c991so5079a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 07:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729003439; x=1729608239; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3lpMQC/f5DBAD5or9lbKKrPkKemScfy3OJSYurxvJuw=;
        b=Jshjfl8HoENTlJS5ZPdRhcVrv9kGtLkumWUd8F/jrq6egISr7gKnVSDa608pB18xKu
         qd2NOhchVkcn8nMws6OGmtC8JKF07CdpUXpxv9dgOx9aUL1u2k1veXRzT76WMVuSwPEe
         rXo91+KcavS2OF7Xi3wfi1G3ug0qVomPwB0xP9gnz8mLiVR6rv9bys4JouoH06oc5olr
         +mwu4WIdHfWw1tByVQS7UB1wh16QuqxojNzrXVQCapMhQKxoEMpEfMdZ6F0qnpW/kpit
         SZ58NTlIObHJalimkfNTFaQreSKiW7Ucr92wF9EP8qrEOHchLrHxX6d8cyoRNgnSagZC
         k0SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729003439; x=1729608239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3lpMQC/f5DBAD5or9lbKKrPkKemScfy3OJSYurxvJuw=;
        b=YXY1fISgwpA3tslGKvZtBC8roL45pzJeZ0P32OSOqaHLElphWzboEPloWD0LzcnORF
         Rk2ldgH48e6W7ZNp8dlzYrcuWY2iYU5FIHZfZDePgW0ANktfOMHAu03ozwbVBSfDYQ2o
         Cn/MFkcIA1umps/APghSEcpHRlZg30aSey4Yv6AGzKxvN+cbhoDKCp2dPZ4zwq0koki9
         kYTQdXtgg240q8AUXgAr8MhhJn1rkZlwzpo6fO8d6opPohdZGvkLQ6I47BPFmJSollNv
         MmQMNn0EoKSvrhFB5GUfpoF2mmx8aCRHQCaQ/f/56pPosrmFtuWixdwpeI2xq9Q/aQR+
         vz0w==
X-Forwarded-Encrypted: i=1; AJvYcCUS/jshFa1Ya9+Q+GK0WzaGjR/pB2YgQE3h/i4+sO5kG/yNI6VZRbXiTpc4KyM6c3vitgB8PsWIzGlphxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIM9SWEsvPw3+IH2NL8Muvx0lLqWRXQ5qw6aD6MGe41YnpoGGJ
	njX3kQrKHilosA+d4lyaJZVhQvKmQa7F1XnHm4P5px1AQmGWPYwSakqKtIxRZRs3PVoSwMr7Ew5
	Bh2d+VohI7v7z1jFfGs7Yqb0lxByUQ0BQ6JGk
X-Google-Smtp-Source: AGHT+IHbGmHwlXDagk/3SF+RGqhVu4RMoqkcx6gh6koiAXSvvuUvpR9ybPtB9PL+HL94OhwZsQuEVgsap2LDWyNUaRQ=
X-Received: by 2002:a05:6402:520f:b0:5c2:5251:ba5c with SMTP id
 4fb4d7f45d1cf-5c95b0cf230mr123871a12.0.1729003438690; Tue, 15 Oct 2024
 07:43:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015111236.1290921-1-david@redhat.com> <bu3aq2gxcfkjxocu3uzowvevlv6rgeihepc36cwuhh44xqydkc@3ghgml6xnlgx>
 <ef49981b-b4ae-4a39-bfb2-7c2065d7bc98@redhat.com>
In-Reply-To: <ef49981b-b4ae-4a39-bfb2-7c2065d7bc98@redhat.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 15 Oct 2024 16:43:22 +0200
Message-ID: <CAG48ez1Sf04jfwWM3J7XFQ2Y_ZP0CT75ASQHuFkgJLdQf2reYw@mail.gmail.com>
Subject: Re: [PATCH v1] mm/pagewalk: fix usage of pmd_leaf()/pud_leaf()
 without present check
To: David Hildenbrand <david@redhat.com>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzbot+7d917f67c05066cec295@syzkaller.appspotmail.com, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 4:40=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
> On 15.10.24 16:32, Kirill A. Shutemov wrote:
> > On Tue, Oct 15, 2024 at 01:12:36PM +0200, David Hildenbrand wrote:
> >> pmd_leaf()/pud_leaf() only implies a pmd_present()/pud_present() check=
 on
> >> some architectures.
> >
> > Should we clarify what behaviour we actually want from arch code?
>
> We probably should document somewhere that things like pmd_special(),
> pmd_leaf() ... should only be used when we know that the PMD is present.
>
> I wonder if we should even add ways to detect mis-use
>
> Jann also raised that recently in a private message, that it is rather
> unclear (well, and repeatedly leads to issues) when pmd_leaf() is valid
> to be called.

I think one place where that should probably be addressed is in
Documentation/mm/arch_pgtable_helpers.rst - that is supposed to be an
overview of these helper functions and what they mean, but the only
thing it currently says about pmd_leaf() is "Tests a leaf mapped PMD",
which doesn't really tell you much more than the function name. It
would be nice if that table contained information about the conditions
under which these helpers may be used.


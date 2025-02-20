Return-Path: <linux-kernel+bounces-523377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B09D8A3D5C2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5456C175841
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EE81F03E2;
	Thu, 20 Feb 2025 09:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FyzBJ0IT"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491871EF0AB
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 09:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740045573; cv=none; b=szGet1H8zbGemQuud68Skf0PaVOi5OQ/xEGu6hgxwfKoDEC1IGs7jjE/JEK5h1LiEjJ9hQxGeZPN/o8fDuq9H86Nla5CxJOSMJ9gCBOsvMqiJzzjwDLWavQuBntvQxfHRIEoOLmk0ok3CYjkJlWNOJUkNkNMKkh+74l4KKnHawQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740045573; c=relaxed/simple;
	bh=uAMWl9PLfDy04Bs+KIcgrODYhWdNOmoMzeRBBUctSss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bGe5Yz0XPLxjN2XcDVgTyyk2y57xYj+ik1vtVvsMlEOOpS6X31pEIKlGYP0DTCu/JABGTcXuuY7S3ccEKa6p49URwGnc5dV0dcd7TavAl3K4tQyOHZ7mV4pysICtgH7Luv4Yr4a08VcUTWGskehM2jEEEZsbVK7ddAoGk9OixUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FyzBJ0IT; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30a2cdb2b98so7293961fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 01:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740045569; x=1740650369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uAMWl9PLfDy04Bs+KIcgrODYhWdNOmoMzeRBBUctSss=;
        b=FyzBJ0IT8gu7btFOGog1SqbrZJgPBxW/HxD9t1zGMt2dS8OykuTfRVtJgam+zdDjRG
         a+6B8JnLatMGm4kWTigyFLl3/mzq3ZOQWvHMy2KyiSyDXtJVqzZtuUqj1/YFLY+ze0E2
         d6xJG+zhHHE5h2BqW1naBz88UkBRxVUaCjcqpBzRsZSO9DBNjlivw2+D/Xbm9ByDbqls
         sgZWMTpjkBO/Lss2PLVL6NzTfOEbEQ/HtBZE9I+LCdk7FP3pk+/yTWBxYxn2oZAqrwFO
         gCAadVET964p1UjRolMWvekFWsTqP6ucb0R7I11o5ndYT4JRjGgMxFezPddlaimzQFMx
         tofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740045569; x=1740650369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uAMWl9PLfDy04Bs+KIcgrODYhWdNOmoMzeRBBUctSss=;
        b=GAgLalb0XRAhggUTsR1mGYn3dzcW5d+s/peHNBRenDO6Fby7RVFlHrT1jdxgrYGrb5
         CbTcZZYgyeEDqKjlqSstdAUsIN0izNtlU1atLq5tsLB9noV3vxaNERHqp4h0Rv4SM+0v
         8sVDLi3sIjsA0vhu7qdrDgU38sDj4bBdE7UdekwMn14+d9UNYeXDDfoJ5DvGi8lddEZB
         U3aukYWMFlqJMki4VwvJMlsJjN99y9D2hJ3x0WeWVdVoQIx9kV5qhmCYj0t+As7SScUP
         pQOOyWUx216VeVxxTAV2TNweIZyBVFX4mrUSnvvdL2riaZvOQLEiZw9FHNUvoOY/m4bM
         lgqw==
X-Forwarded-Encrypted: i=1; AJvYcCWXq2LuIJpoltK0GS9DqgfdtHJ1UPz0OQySKEs8TerC6qIlTc1snHqJz7UhdodNuqjGQRbXNOGL4N0BV2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRvvsPFIQaCOSUUKDMaU5wknSJTY9D8nXDwYO1OrjN8IHrJ+Em
	Iv2jAS96EOnierArvgRjBhEXOvVIlSMJs+YuYl6SRCTODsUS4iKtCDsSfE9FEjOb+df9RhAS7Ml
	5OO4sQU7LsRVLraXp0WBb64e2b2w=
X-Gm-Gg: ASbGncvBrwT36+zQ0F1qAadGGzidHTsUIpp5w17ReOEZDYirbomyyRRwotz7iNtFLph
	9UW05ofRufzTUQkufUx5RemD+H6RUIz/DjloyOya1ndoHcNYxpcy/8Myzi9LCMi2LeX8bzrHN5T
	4=
X-Google-Smtp-Source: AGHT+IFIsSsy0MCPsjXngTu6cybUiCgLNfAULaQySW6JHJyT7glm8RIKirUFoVrvZjgX7bTK37tA+hGGoo7kNDxXcqc=
X-Received: by 2002:a2e:9bd4:0:b0:308:f827:f8fa with SMTP id
 38308e7fff4ca-30927b1e718mr62333121fa.27.1740045569014; Thu, 20 Feb 2025
 01:59:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219072504.1655151-1-rand.sec96@gmail.com>
 <v3rsldvzq4ujgcxamjwcmmfm62wgdgjscg25c6t6xph3itjedp@sbuayguprw2i>
 <CAN8dotnkd-fSQurTFAf_8z3K1yRNj5SVJ4qYc3Tq7cVZLq02qA@mail.gmail.com> <tx4mjsvkleki6butsmbh533y6w55rt44zaorh6auhjyfgzunj3@oaiwslri6x5h>
In-Reply-To: <tx4mjsvkleki6butsmbh533y6w55rt44zaorh6auhjyfgzunj3@oaiwslri6x5h>
From: Rand Deeb <rand.sec96@gmail.com>
Date: Thu, 20 Feb 2025 12:59:16 +0300
X-Gm-Features: AWEUYZkJyg6yWlqtbY5rQ-SpHsGBNhAbsYs9C2cvgGTGSuJDI8kwfsCK3CkTikQ
Message-ID: <CAN8dotmC55rYdRjz_nph+C8ZU7K49wC4TEGWA4xjzhM0rjix6g@mail.gmail.com>
Subject: Re: [PATCH 5.10.y] fs/jfs: cast inactags to s64 to prevent potential overflow
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Dave Kleikamp <shaggy@kernel.org>, jfs-discussion@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org, voskresenski.stanislav@confident.ru, 
	Rand Deeb <deeb.rand@confident.ru>, lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 2:37=E2=80=AFPM Fedor Pchelkin <pchelkin@ispras.ru>=
 wrote:
> Yes. And not specifically, but deliberately (it's a requirement). The
> existing problems should be fixed there at first.

Done. Thanks again for the feedback!


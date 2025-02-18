Return-Path: <linux-kernel+bounces-519661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CC9A3A064
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E079162502
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8828826AAA8;
	Tue, 18 Feb 2025 14:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKGuRjY7"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BCC2698AD;
	Tue, 18 Feb 2025 14:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739889712; cv=none; b=RAaDuHY6Xhipf+57KVHdJ4mMwodSW+liLQr9pNDhaFRceaw1QTnq+TaijDqU+Q1A9HDea1u7WoZXKl+y6Vw/ak7WKM3hf6cksw/lo8Os1mrFoTnZfE9Dv5f6Nwj6qrVF/4DqKDbAjKYe4awVD4St+hWPENCFVluFewpjVyjsw9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739889712; c=relaxed/simple;
	bh=ITyjbYorInb7OznbRdsHM3rzrKeWxNDblHgtrnPmcW0=;
	h=From:Message-ID:Subject:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O+oVrmfqa/AWBJhfu22kJ00qResbXmrmYpMJlgkdgp4M+IZjBLXhg6gotgqKR9BXFYsAhptdP5GI2tDpDpgDDZtcV8SoCRcc41jRlINUxfG8ImGEvQxyYUT87yJB2HuZoZ+tJhHjRfjVFMMcxSj1d5A+lMuYiM5cIh4C/kXtMVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EKGuRjY7; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aaf900cc7fbso834832366b.3;
        Tue, 18 Feb 2025 06:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739889708; x=1740494508; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:subject:message-id:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ITyjbYorInb7OznbRdsHM3rzrKeWxNDblHgtrnPmcW0=;
        b=EKGuRjY7SKkcAR/JPwSvtk+XSjvxST4fUU4QpsCHBYvOQ/xirXCS+kZWjSdPJQVyrW
         b0mvlNww5E7y/bKD4owgovbY/zBAQXjfCkZJdylMYDP5fzJNHgkj1jJdVa2Tfxem+Czx
         bU2HI+V/24SQ64L4EAmaKSj+FoirNXZkNdXZbg1Cr/+cZJDXHJi7htZi686zgODeqsjm
         xuZUEuodyGMXS293AQvhgwbNGZapT+swRuAKcU2HM6Q+vH/L1pL+FqdNo3ASzVWlPI+m
         71b0fdpoC+um7RVf9OfxmKaMLiP551bCxfTcAUqD27WabBfodp5nXV++N2kq6eXeOYrY
         /YaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739889708; x=1740494508;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:subject:message-id:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ITyjbYorInb7OznbRdsHM3rzrKeWxNDblHgtrnPmcW0=;
        b=pXtxPIpGSRQKVr9aiZRl3Ok+d250LMahVi3gvHsf1GTvIc7rao3clX7mXuj2nSWk0x
         j2JqY05GgySvUpKtN13ct4ykFdO05UKafCI1qkEvL5I+XnVczYYP/Q9RP7eA6AZCUYiL
         R8RIs7MSr5sQE2ZM7m1KwiVVdJQth7uFFfgEGBjdiA2/k2WcWJA6cvDQtvZ10iNjq5gV
         4zk9vc+ZX289bjnGFtpu/9zf03lpRx3lbXWufp+q0QUwQrgizRFQmhab6QpkCok6/Rsk
         eY0L8bddm557vWjd3R+TwkuewULY2Lu4A0TG+dX+8oHTlKJA10ufvD5DGzFh1ZMDcsDT
         x/lg==
X-Forwarded-Encrypted: i=1; AJvYcCW+LEhdA9H0VC7+wXEIHGlPogU85R1aDR5ZGWLAUN3F1gQ3ftzuS2UMt0ziJ9EHxebf7tMk5Edidc7oXzMh@vger.kernel.org, AJvYcCWmT4ELyjceM8GLdXx4Raf/mCRc8deoKuaGFQCQ32tpWtqtXoqeQSCFwwwWmz6fjeiIbiTUw0LTOTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAc1JvRppEJAzSuP1SZlw6sScS6b9AW4fT6teflJ6S1NdIY7Fm
	96CCrABhlqrc2e5zgri3qOy5M9+9qdcsLBNIKw+4yc6WaVQuPSmPYSZFIMEN
X-Gm-Gg: ASbGnctHhh8oIs+rU1RMAfta1cUkcfjUXHTOD54qrCBFPeBeJoJjgAAFLbCK2XYPol1
	qqJcQEPaOzW/rFGPqSlmIsaO8wULbGPPe0k0Exhi7igo20IpWbhODhW+XgOAzBMkipFng3rzcZn
	OeEvSJfsZID3AOnF68ZpqQgbm8dbNKUqSbjV0kM4DC+H810C3YJL5OxCCtpZmpp9z3JVBu6Ez8S
	VqfIQvpve54nVdmkTNUE+bIvTFXOAOBN/PGEzBS7nP76rZexAd21nwoLtqseGQR7K47UqqUykMW
	2jc2hmkeeasgXLfwhNVdVN3IMGTkark=
X-Google-Smtp-Source: AGHT+IH6i7PubfoI0VxPwiBEI2XGJO3sNuV4rkMcAu6hxu6WANeiFNV7c6fgc7v8xsbF1vHRESeg8g==
X-Received: by 2002:a17:906:6a0c:b0:ab2:f8e9:5f57 with SMTP id a640c23a62f3a-abb70a957b5mr1237493366b.21.1739889708291;
        Tue, 18 Feb 2025 06:41:48 -0800 (PST)
Received: from [192.168.101.162] ([212.123.204.195])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba9cf8a262sm783983266b.22.2025.02.18.06.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 06:41:47 -0800 (PST)
Sender: Armin M <arminmahdilou@gmail.com>
From: Armin Mahdilou <armin.mahdilou@gmail.com>
X-Google-Original-From: Armin Mahdilou <Armin.Mahdilou@gmail.com>
Message-ID: <b45c5b7c1ec72697005afbbf870100cc4a175572.camel@gmail.com>
Subject: Re: [PATCH v2] Documentation: proofreading Documentation
To: corbet@lwn.net
Cc: shuah@kernel.org, skhan@linuxfoundation.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rdunlap@infradead.org
Date: Tue, 18 Feb 2025 15:41:47 +0100
In-Reply-To: <20250210192754.30283-1-Armin.Mahdilou@gmail.com>
References: <87bjv91yi3.fsf@trenco.lwn.net>
	 <20250210192754.30283-1-Armin.Mahdilou@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-02-10 at 20:25 +0100, Armin Mahdilou wrote:
> Fixed some spelling issues in documentations.
>=20
> Signed-off-by: Armin Mahdilou <Armin.Mahdilou@gmail.com>
Hi all,

Just a kind reminder about this patch.
I would like to know the status of it and as it's my first patch,
I want to know how can I track if it's merged or not.
Thanks in advance.

Regards,
Armin


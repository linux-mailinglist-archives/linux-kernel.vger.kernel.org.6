Return-Path: <linux-kernel+bounces-393432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 653449BA08C
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 14:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6790C1C20F65
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 13:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E4818A92E;
	Sat,  2 Nov 2024 13:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mka2bkOo"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4351BDC3
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 13:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730554424; cv=none; b=c+Yn+nct5fejjao3xIGe1GhuTeEJWKO1Z11kXNDyErj2tpPB071BpdOZMr9LFhRqM96h2GoJnWgftg6Syaw3Ngo0FbtpUUNhbznbiYGX97wT9mSy8WlbuGi/4vTtpd8GR0fLVPfaCpaAqe/DnOE5wPTZQttwf/cOvy+KT29sq6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730554424; c=relaxed/simple;
	bh=YIqagV1NwTECAGQHhrIvxosUcV32d/Vxh+4ati1x+Gg=;
	h=From:Message-ID:To:Subject:Date:MIME-Version:Content-Type; b=B3NUTIjuhW+nXkGCMg4jvhV5IltDBMGJaZP2wdQyjM0WdmHSEekG9UyhnPu0EoOuYTpya7+1oEbd0PTfLXYutJTSTaQ7h8zQfnOh7PO9Xcd+IMykFrKySitSTDOfXeyDFetaNK9Ai9QY5QTlJiDh6OYmiD+RWYsl3tQyyOpqVU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mka2bkOo; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a93c1cc74fdso407924966b.3
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2024 06:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730554421; x=1731159221; darn=vger.kernel.org;
        h=mime-version:date:subject:to:reply-to:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YIqagV1NwTECAGQHhrIvxosUcV32d/Vxh+4ati1x+Gg=;
        b=Mka2bkOoIUOt9uRuAW1XwER3pHN0UNg9/DSJVSTBl3L7fIQB/LG0c4/WCziDRCZ6CQ
         jihwyykljDLT0usYbSIz+b5TEOfiN6czj5ucoVmZVefSXNfr72UNqD62orY6kCGsQtRe
         NgT8qLrIdQj9sfx4OQ3/qjLb7lOj7OwLb+AzEgVA11dq9jo1TKtvhN/M7JBinro2riI+
         i+GjJNRWhIS6g4cIcgKOgwYklDzf0CBfzbN8dBaBeWm6XG+ubO05Jne28SkloQYSdCI3
         RgLZarjjBZ8+fn5+hVPrCD7wqzRrAlYTZZCt9nm9oy+tfNN57r3rx97LoQD3uv9A5nZQ
         OWjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730554421; x=1731159221;
        h=mime-version:date:subject:to:reply-to:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YIqagV1NwTECAGQHhrIvxosUcV32d/Vxh+4ati1x+Gg=;
        b=gefNtuTniS3Zbm4VLdSANAUzgX5ibf9Zea+bRldeOryAd8qbNWt+JZmzI8PCamREYn
         w90JZUsGPfLRdfJ/AxWpQuCp8kb/wCCPjHpWEmOmxbqzwF+jKv3izG8IAxYTmCsFVenZ
         Qgrl/ywQgt15TgOlvStM8aLPp+J1CaRotO+gVApF+kO6L3/cIMj51HuQTyFE7ttyEih2
         NWU/E7LEVwzXhdtzIuhA1Ty0fIOO2sT0/PvLUCGaCVyIxzlKAW+1TEy/T8kx8Y5EGMdc
         34e9lpoEefIANXpJqqe335xGL4iwx+u956vVnOV4QDZJJRThpHB7tqQ4i3Cp4QIz/XeE
         ZFuw==
X-Gm-Message-State: AOJu0YzeEdaAIzcY5UWB5inUfvZAvNdpZC8wLqkaMhguhF47G0jYoJwt
	nXY1x1aM5HjKpU5pX/SRu/+qfXfvHbv6x40d/I41tMo/uAy3tXT9kb1Pmw==
X-Google-Smtp-Source: AGHT+IHN5FZTvJq1ubji121q3xEIlqunRIqoWQibr2+soUm55Fggkh4zqoiP/mBUg25z/NnhcLrsKw==
X-Received: by 2002:a17:906:4789:b0:a9a:f84:fefd with SMTP id a640c23a62f3a-a9e655b6912mr595655966b.36.1730554421033;
        Sat, 02 Nov 2024 06:33:41 -0700 (PDT)
Received: from [87.120.84.56] ([87.120.84.56])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e56498413sm308403166b.32.2024.11.02.06.33.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Nov 2024 06:33:40 -0700 (PDT)
From: William Cheung <rinky.khatun.doratana@gmail.com>
X-Google-Original-From: William Cheung <info@gmail.com>
Message-ID: <8cbd7f3a056e942beba9d476b51e9757d140ea15a7ee97dc5912a383b1473958@mx.google.com>
Reply-To: willchg@hotmail.com
To: linux-kernel@vger.kernel.org
Subject: Proposal for you!
Date: Sat, 02 Nov 2024 06:39:27 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

Hello Dear,

I have a lucratuve proposal for you, reply for more info.

Thank you,
William Cheung


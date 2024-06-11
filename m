Return-Path: <linux-kernel+bounces-210620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF3E90464E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 23:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 052F01C235E9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 21:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0657B14B96C;
	Tue, 11 Jun 2024 21:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ppe/Mzfv"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDCA2033E
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 21:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718141888; cv=none; b=f/fWs58GTM0xkGfbTY54A3++R1SMoyEHfmw8YeLOljSZzA7LmawWgoTff2288nwgysdw2UflU82CGZRLFNkvMjzjoH0l+v6Ot3pByQ+2uH5Gxqeo6A/JoWfwWHqUqP/2XqY5J85qdUDx0EPc9AUKZ0D/4/V/e840FBPVK+9m/MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718141888; c=relaxed/simple;
	bh=ySqUTx0evazFjjELB84p1DsaP5eR3ADWvtGXHiLCUdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hxr5TcQAY4EJfOu2KP+fzEg8Yzz26OzigTIM1dwsD1ybx0Tu6yYr/1pl1z63tauFhzA28BM4RAITUK9YeJ5iZYaiaIYWeaz4QwzjIJ4bqKbxEAn9GvWpqicQeVSlTsQz2WFzYfF0seotcdy0J0Dz8yZtpdSSyhMgn1iuY53BXI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ppe/Mzfv; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5b9a5be6668so715839eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 14:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718141885; x=1718746685; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SpKLP3/PYYk2S5W110YgI1G09xFxTWkXzi4V4Rve3Bg=;
        b=Ppe/MzfvI7EL7WIa/qDMvSU6ouHVhrJTG2hk/2uxNbyVF6lm0T3/Ex0GoMFMMoN+hw
         jNXRC52H6HiNIfWVKLasHJ+/gcL7ojr59sEpx0RnKD4fXHJm7qVjKsKV4U9JZjj+8waq
         /kU5DjwBDkhB4OCVGTTicLV/gDmHpcEisCAFbLbS7QgVg79ZuO5JiQgsUL5g2TqbLbCI
         ybdcsLgxrRTDv/R1aOy+CuhlhFrIITsv2XY1GNcwnomwyNy/62QoAapdJB7wZU4n9lnp
         GlL3kxb/ZT11tBtZYJtEhLjL/YSzg+zfrL5WNrPal3RlcSqfTlyujQAioYbjBe+lxymb
         4Qug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718141885; x=1718746685;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SpKLP3/PYYk2S5W110YgI1G09xFxTWkXzi4V4Rve3Bg=;
        b=l5fSwTr2R04GSJrWXlZqei4Ml1YfEo5XhKvYJrSwhOoJ9I6LjPxdKi9gDxIK2oOOzM
         CE2fI+tod/ZfocYzT3fBGszKe+043Vc5pd8g4PlXKt+EkSeRROPRxix++ad9OiVAGPcd
         KQF5vaeKBhjU3q7/cW6vJruoV81CpgZgrq26AqzBV1yU2vj8+StDMBFCemfLh/rUH0Cy
         iFeAzf0O4E0VsN+YuVuL/+LodjzUIiFMtW3xWbSkRAWGMsgDlTrTpvAjUlVXfD3rZ4pu
         tgKY+QIfuKcHrIrvcvAHW5VJ672UhEB0EB/QDmpZgxH6zHvDQWkGXCwNsKThzAMu5nfB
         gPbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQX2PgUVdgRTvGk9pnREaFzTCjBzNLS0zpzM3S0xVTV2wMFybK0c06ZDYNKWhzxWOgvLcmbrGEcHfN2ORGcyKMTuuV8i3kYNFOvbQ8
X-Gm-Message-State: AOJu0YzWzmTtg/OgsQuza5tb1QbVy0CaGA1vEWV94TcSWHRyTxSfsImZ
	2uNWpPEMa+IdJgo10dBzC4xm1jYLWNN7UIzwnszwx2Q6cQduvql+
X-Google-Smtp-Source: AGHT+IFaNdobBN4HbuBoXAPQXnoOTWeSKZhfmlCo9gp66hdSTlHzKfS6h39kIEf2QODmThRg01SyLA==
X-Received: by 2002:a05:6358:914a:b0:19f:3a23:87a with SMTP id e5c5f4694b2df-19f69d9c14amr20293355d.20.1718141885077;
        Tue, 11 Jun 2024 14:38:05 -0700 (PDT)
Received: from localhost ([216.228.127.131])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6de200843afsm8051313a12.10.2024.06.11.14.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 14:38:04 -0700 (PDT)
Date: Tue, 11 Jun 2024 14:38:02 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Andi Shyti <andi.shyti@kernel.org>, Lee Jones <lee@kernel.org>,
	Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
	Johannes Berg <johannes.berg@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Robert Richter <rrichter@amd.com>, Vinod Koul <vkoul@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Nikita Kravets <teackot@gmail.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Eric Biggers <ebiggers@google.com>,
	Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	John Johansen <john.johansen@canonical.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Takashi Iwai <tiwai@suse.de>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Mark Brown <broonie@kernel.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	David Howells <dhowells@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Sergey Shtylyov <s.shtylyov@omp.ru>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Peter De Schrijver <pdeschrijver@nvidia.com>,
	Prashant Gaikwad <pgaikwad@nvidia.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@redhat.com>,
	Jean Delvare <jdelvare@suse.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Pavel Machek <pavel@ucw.cz>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Kalle Valo <kvalo@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jason Baron <jbaron@akamai.com>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Clemens Ladisch <clemens@ladisch.de>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v1 1/1] treewide: Align match_string() with
 sysfs_match_string()
Message-ID: <Zmi9bVdd8uNeqkWl@yury-ThinkPad>
References: <20240603211538.289765-1-andriy.shevchenko@linux.intel.com>
 <87tti9cfry.fsf@intel.com>
 <CACRpkdZFPG_YLici-BmYfk9HZ36f4WavCN3JNotkk8cPgCODCg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdZFPG_YLici-BmYfk9HZ36f4WavCN3JNotkk8cPgCODCg@mail.gmail.com>

On Mon, Jun 10, 2024 at 10:08:00AM +0200, Linus Walleij wrote:
> On Tue, Jun 4, 2024 at 9:46 AM Jani Nikula <jani.nikula@linux.intel.com> wrote:
> 
> [Maybe slightly off-topic, ranty]
> 
> > Why do we think it's a good idea to increase and normalize the use of
> > double-underscore function names across the kernel, like
> > __match_string() in this case? It should mean "reserved for the
> > implementation, not to be called directly".
> >
> > If it's to be used directly, it should be named accordingly, right?
> 
> It's a huge mess. "__" prefix is just so ambiguous I think it just
> shouldn't be used or prolifierated, and it usually breaks Rusty Russells
> API rules times over.
> 
> Consider __set_bit() from <linux/bitops.h>, used all over the place,
> in contrast with set_bit() for example, what does "__" represent in
> this context that makes __set_bit() different from set_bit()?
> 
> It means "non-atomic"...
> 
> How does a random contributor know this?
> 
> Yeah, you guess it. By the token of "everybody knows that".
> (Grep, google, repeat for the number of contributors to the kernel.)
> 
> I was considering to send a script to Torvalds to just change all
> this to set_bit_nonatomic() (etc) but was hesitating because that
> makes the name unambiguous but long. I think I stayed off it
> because changing stuff like that all over the place creates churn
> and churn is bad.

Hi Linus,

I think about renaming set_bit() stuff for atomicity at least twice
a year. But it would be over 15000 renames for set and clear_bit only:

yury:linux$ git grep -w -E "set_bit|clear_bit"|wc -l
12972
yury:linux$ git grep -w -E "__set_bit|__clear_bit"|wc -l
2914

Anyways, if someone is brave enough to do that... The main problem is
that set_bit() is heavily abused because people don't bother putting
the '__' thing, which leads to using atomic helpers where non-atomic
versions are enough. 

So the right path for renaming would be:

s/set_bit/atomic_set_bit
s/__set_bit/nonatomic_set_bit
/* Wait for a full release cycle or two to let people get used, then */
#define set_bit nonatomic_set_bit

Thanks,
Yury

PS. Had to drop all maillists except for LKML and some random victims
because my gmail account doesn't allow more that 100 recipients. If
you guys know how to increase the limit, please advise.


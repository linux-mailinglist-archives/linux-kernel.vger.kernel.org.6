Return-Path: <linux-kernel+bounces-425742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A96179DEA0E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 16:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B25C2813E1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 15:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DA519E7D0;
	Fri, 29 Nov 2024 15:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddzl/TVU"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE01A13D619;
	Fri, 29 Nov 2024 15:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732895943; cv=none; b=M27xKsMj5Szf6uCRl3ngZyp8Uuj/40cgHR9Kbk1AGYEa46bKPAJuXKynR09QjIaFjBg1n1NBX6NDsJMAAU0sSFkRiupA+HwRroues2JnR7vQy29gv146+2IYjU5LjPqdGiBYckFswTYA6tjmM7l90dR8f/6XeddnhJC03qeuGTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732895943; c=relaxed/simple;
	bh=Fy/M2E538vc9eRpfXKALjrJRV+gP0+14bDrv6TrmK0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KW+Wf5puSOSzUd6XM4IlUIQ+CQD7wRrMXS9fK+5kuMimz2LS5U4Z8cR5zx9nXzvK3HiY/McGjXhSDB0GphfWr9MJ4xm+QivJFdJt0n/H1TLYSV8OSVBlEXSooFBtqgAL9+/oCAn0YM0S+K5w8FFoQZa4XkCyGJa/+s8kaSmj76M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ddzl/TVU; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-71d5984e56fso838084a34.3;
        Fri, 29 Nov 2024 07:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732895941; x=1733500741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sn9lfr8ePtR9WA1qAJtFEJLICpFE6nvqUuxa8WmTw4Q=;
        b=ddzl/TVUxyzVOLD54yrMUOWP49Q06bY8Syg373lFsgd5NG9CchGUnv8P+4PJ6a9jQt
         u6BftErIS7MKGTrXAsj/yyavVSwKavBp03A4391P8EolVjwK6nsCgstGH1+jl5AJgv1c
         Fureusm+ZEr0QmDWW3+4npWXrsrd6PRJoKve5NuHm38OtjNvEC2QN2eUrwPFXxNxgH1j
         pmDNQZv5nQ3K84P2/FpL2UU1wqKzhV3J8o+rpHpTFiAtYUUpZ1V6y9a0j3TrZbkiADUC
         mReGnF23KisxtZSH7z07cxc1E1BRSXibGDsr9VelwaPiGoSgY/qwGn+9x+USdhvFkx9o
         gttg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732895941; x=1733500741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sn9lfr8ePtR9WA1qAJtFEJLICpFE6nvqUuxa8WmTw4Q=;
        b=i9NxhqLM5vTgyxQPI/5EzQvC2LH+QaQkwKnvb4pxMvNMoeI8JDmTNJ3LEcjYbxTh/e
         U3MDah4mxwjOQT76dydsjBmGgJSwfOL2sp4Pl3tBc1tXEDP+k89/oYuAr6aA9X9C6ig8
         m0qkNCezxOiuiCo/Hg0rEYFfQaZiO5PtmJzuKs1nH5wAx1zjH3wlnHWRl1WiIaQ+Ib2l
         XKUnwL6qo5EPhrZV8lQqn0J9ROY9pr0LOrw3+EeQ0wNZzTKvuklcOZjkwKwc6AOEy81b
         vySKICXcGedNX1EpoSHwDqb92x8fMHTHfJqKZe1ni/7WRqS2RqEC+7kdz/NmATpgOal+
         Ayww==
X-Forwarded-Encrypted: i=1; AJvYcCW9Rn8vK3XXimK1aVr3maBbyryRArmiGamRwyPHRPhQYV3trwuIh80Qq/mLe2X5V+HHblKvu7YO1m2X2Jw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWzpDj9AvCemnZTXz4crj6TQtoeUBDoxcgunsGNStNdHMdLexX
	+90UK+LJpzhwAPz1INlE77nftMM8QylmArcBW7YDK6LWqYMEwxsQ30skrQ==
X-Gm-Gg: ASbGncsYxBAvfyeyZQDg01eks08MSe+qwSdXVCb4p44VNiOm5EXYzPXbSp9Qa1P1i/F
	hfK+BXGBAfynx0t5P2dMysAgHke16S8j715d9lJvel/XkMvHoeNRJdVP9BKPmiC7csCFj0mC8r/
	NwR1+rYoBDazZ9kGi77Hmliuj9+a6Wx00k+0++VQZsvGKTz2wxNNIki+WF0ADN+0czdukE0QXkW
	GvxMNhgyKjNWyV2YVjxG+lhLtKpcB7/h6FPJcbYNhJtOJwl5fZT4123zRCSx5P7E5Ir3EQBkZ5t
X-Google-Smtp-Source: AGHT+IHIkXjv6XWZH93Poj83mh/hHHNNPXC44BupbJE2oKJDQf7iqxic/mpI3Un09SKVRJ+cNLHKnA==
X-Received: by 2002:a05:6830:25d0:b0:718:9bac:58a5 with SMTP id 46e09a7af769-71d65c94f10mr6392281a34.11.1732895940776;
        Fri, 29 Nov 2024 07:59:00 -0800 (PST)
Received: from pipaware.tx.rr.com ([2603:8080:7400:36da:dff5:4180:2562:4c1e])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71d725f2251sm794385a34.68.2024.11.29.07.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 07:59:00 -0800 (PST)
From: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
To: corbet@lwn.net,
	avadhut.naik@amd.com,
	bilbao@vt.edu
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
Subject: [PATCH 4/7] docs/sp_SP: Add translation of process/6.Followthrough.rst
Date: Fri, 29 Nov 2024 09:58:44 -0600
Message-ID: <20241129155851.1023884-5-carlos.bilbao.osdev@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241129155851.1023884-1-carlos.bilbao.osdev@gmail.com>
References: <20241129155851.1023884-1-carlos.bilbao.osdev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Translate Documentation/process/6.Followthrough.rst into Spanish.

Co-developed-by: Avadhut Naik <avadhut.naik@amd.com>
Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
Signed-off-by: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
---
 .../sp_SP/process/6.Followthrough.rst         | 223 +++++++++++++++++-
 .../sp_SP/process/development-process.rst     |   1 +
 2 files changed, 222 insertions(+), 2 deletions(-)

diff --git a/Documentation/translations/sp_SP/process/6.Followthrough.rst b/Documentation/translations/sp_SP/process/6.Followthrough.rst
index f0acf9082bb3..083898af46f5 100644
--- a/Documentation/translations/sp_SP/process/6.Followthrough.rst
+++ b/Documentation/translations/sp_SP/process/6.Followthrough.rst
@@ -1,11 +1,230 @@
 .. include:: ../disclaimer-sp.rst
 
 :Original: Documentation/process/6.Followthrough.rst
+:Translator: Carlos Bilbao <carlos.bilbao.osdev@gmail.com> and Avadhut Naik <avadhut.naik@amd.com>
 
 .. _sp_development_followthrough:
 
 Seguimiento
 ===========
 
-.. warning::
-	TODO aún no traducido
+Llegados a este punto, ha seguido las directrices dadas hasta ahora, lo que
+sumado a sus propias habilidades de ingeniería, ha resultado en una serie
+de parches perfectos. Uno de los mayores errores que incluso los
+desarrolladores de kernel experimentados pueden cometer es concluir que su
+trabajo ya está hecho. En verdad, publicar parches indica una transición a
+la siguiente etapa del proceso, con, posiblemente, bastante trabajo aún por
+hacer.
+
+Es raro un parche que sea tan bueno en su primera publicación que no haya
+espacio para la mejora. El proceso de desarrollo del kernel reconoce este
+hecho y, como resultado, está muy orientado hacia la mejora del código
+publicado. Y usted, como autor de ese código, se espera que trabaje con la
+comunidad del kernel para asegurarse de que su código esté a la altura de
+los estándares de calidad del kernel. No participar en este proceso es muy
+probable que impida la inclusión de sus parches en la línea principal.
+
+Trabajando con revisores
+------------------------
+
+Un parche de cualquier importancia resultará en una serie de comentarios de
+otros desarrolladores a medida que revisan el código. Trabajar con los
+revisores puede ser, para muchos desarrolladores, la parte más intimidante
+del proceso de desarrollo del kernel. Sin embargo, la vida puede ser mucho
+más fácil si tiene en cuenta algunas cosas:
+
+- Si ha explicado bien su parche, los revisores entenderán su valor y por
+  qué se tomó la molestia de escribirlo. Pero ese valor no les impedirá
+  hacer una pregunta fundamental: ¿cómo será mantener un kernel con este
+  código en él cinco o diez años después? Muchos de los cambios que se le
+  pueden pedir que haga, desde ajustes de estilo de codificación hasta
+  reescrituras sustanciales, provienen de la comprensión de que Linux
+  seguirá existiendo y en desarrollo dentro de una década.
+
+- La revisión de código es un trabajo arduo y es una ocupación
+  relativamente ingrata; la gente recuerda quién escribió el código del
+  kernel, pero hay poca fama duradera para aquellos que lo revisaron. Así
+  que los revisores pueden ponerse de mal humor, especialmente cuando ven
+  los mismos errores repetirse una y otra vez. Si recibe una revisión que
+  parece enojada, insultante o abiertamente ofensiva, resista el impulso de
+  responder de la misma manera. La revisión de código se trata del código,
+  no de las personas, y los revisores de código no lo están atacando
+  personalmente.
+
+- De manera similar, los revisores de código no están tratando de promover
+  las agendas de sus empleadores a expensas de la suya. Los desarrolladores
+  del kernel a menudo esperan estar trabajando en el kernel dentro de
+  varios años, pero entienden que su empleador podría cambiar.
+  Verdaderamente, casi sin excepción, están trabajando hacia la creación
+  del mejor kernel posible; no están tratando de causar incomodidad a los
+  competidores de sus empleadores.
+
+- Esté preparado para solicitudes aparentemente ridículas de cambios en el
+  estilo de codificación y solicitudes para factorizar parte de su código
+  en partes compartidas del kernel. Una de las tareas que realizan los
+  maintainers es mantener las cosas con una apariencia uniforme. A veces, esto significa que el truco ingenioso en su driver para sortear un problema necesita convertirse en una característica generalizada del kernel lista para la próxima vez.
+
+En resumen, cuando los revisores le envían comentarios, necesita prestar
+atención a las observaciones técnicas que están haciendo. No permita que su
+forma de expresarse o su propio orgullo le impidan hacerlo. Cuando reciba
+comentarios de revisión sobre un parche, tómese el tiempo para entender lo
+que el revisor está tratando de decir. Si es posible, arregle las cosas que
+el revisor le está pidiendo que corrija. Y responda al revisor:
+agradézcales y describa cómo responderá a sus preguntas.
+
+Tenga en cuenta que no tiene que estar de acuerdo con cada cambio sugerido
+por los revisores. Si cree que el revisor ha malinterpretado su código,
+explique lo que realmente está sucediendo. Si tiene una objeción técnica a
+un cambio sugerido, descríbalo y justifique su solución al problema. Si sus
+explicaciones tienen sentido, el revisor las aceptará. Sin embargo, si su
+explicación no resulta persuasiva, especialmente si otros comienzan a estar
+de acuerdo con el revisor, tómese un tiempo para reflexionar nuevamente
+sobre las cosas. Puede ser fácil quedar cegado por su propia solución a un
+problema hasta el punto de no darse cuenta de que algo está
+fundamentalmente mal o, quizás, ni siquiera está resolviendo el problema
+correcto.
+
+Andrew Morton ha sugerido que cada comentario de revisión que no resulte en
+un cambio de código debería resultar en un comentario adicional en el
+código; eso puede ayudar a los revisores futuros a evitar las preguntas que
+surgieron la primera vez.
+
+Un error fatal es ignorar los comentarios de revisión con la esperanza de
+que desaparezcan. No desaparecerán. Si vuelve a publicar código sin haber
+respondido a los comentarios que recibió la vez anterior, es probable que
+descubra que sus parches no van a ninguna parte.
+
+Hablando de volver a publicar código: tenga en cuenta que los revisores no
+recordarán todos los detalles del código que publicó la vez anterior. Así
+que siempre es una buena idea recordarles sobre problemas planteados
+anteriormente y cómo los manejó; el registro de cambios del parche es un
+buen lugar para este tipo de información. Los revisores no deberían tener
+que buscar en los archivos de la lista para familiarizarse con lo que se
+dijo la última vez; si les ayuda a tener un buen comienzo, estarán de mejor
+humor cuando revisiten su código.
+
+¿Qué sucede si ha intentado hacer todo bien y las cosas aún no van a
+ninguna parte? La mayoría de los desacuerdos técnicos pueden resolverse
+mediante discusión, pero hay momentos en los que alguien simplemente tiene
+que tomar una decisión. Si realmente cree que esta decisión está en su
+contra de manera incorrecta, siempre puede intentar apelar a una autoridad
+superior. En el momento de escribir esto, esa autoridad superior tiende a
+ser Andrew Morton. Andrew tiene un gran respeto en la comunidad de
+desarrollo del kernel; a menudo puede desbloquear una situación que parece
+estar irremediablemente bloqueada. Sin embargo, apelar a Andrew no debe
+hacerse a la ligera, y no antes de que se hayan explorado todas las demás
+alternativas. Y tenga en cuenta, por supuesto, que él puede no estar de
+acuerdo con usted tampoco.
+
+¿Qué pasa después?
+--------------------
+
+Si un parche se considera algo bueno para agregar al kernel, y una vez que
+se hayan resuelto la mayoría de los problemas de revisión, el siguiente
+paso suele ser la entrada en el árbol del mantenedor de un subsistema. Cómo
+funciona eso varía de un subsistema a otro; cada mantenedor tiene su propia
+forma de hacer las cosas. En particular, puede haber más de un árbol, uno,
+quizás, dedicado a los parches planificados para la próxima ventana de
+fusión y otro para trabajos a más largo plazo.
+
+Para los parches que se aplican a áreas para las que no hay un árbol de
+subsistema obvio (parches de gestión de memoria, por ejemplo), el árbol
+predeterminado suele ser -mm. Los parches que afectan a múltiples
+subsistemas también pueden terminar pasando por el árbol -mm.
+
+La inclusión en un árbol de subsistema puede dar mayor visibilidad a un
+parche. Ahora, otros desarrolladores que trabajan con ese árbol recibirán
+el parche por defecto. Los árboles de subsistemas típicamente alimentan
+linux-next también, haciendo que su contenido sea visible para la comunidad
+de desarrollo en su conjunto. En este punto, hay una buena probabilidad de
+que reciba más comentarios de un nuevo conjunto de revisores; estos
+comentarios necesitan ser respondidos como en la ronda anterior.
+
+Lo que también puede suceder en este punto, dependiendo de la naturaleza de
+su parche, es que aparezcan conflictos con el trabajo que están realizando
+otros. En el peor de los casos, conflictos pesados de parches pueden
+resultar en que algunos trabajos se pongan en espera para que los parches
+restantes puedan ser ajustados y fusionados. Otras veces, la resolución de
+conflictos involucrará trabajar con otros desarrolladores y, posiblemente,
+mover algunos parches entre árboles para asegurarse de que todo se aplique
+sin problemas. Este trabajo puede ser un dolor, pero cuente sus
+bendiciones: antes de la llegada del árbol linux-next, estos conflictos a
+menudo solo surgían durante la ventana de fusión y tenían que ser abordados
+de prisa. Ahora pueden resolverse con calma, antes de que se abra la
+ventana de fusión (merge window).
+
+Algún día, si todo va bien, iniciará sesión y verá que su parche ha sido
+incluido en el kernel principal. ¡Felicidades! Una vez que la celebración
+termine (y se hayas agregado al archivo MAINTAINERS), vale la pena
+recordar un pequeño hecho importante: el trabajo aún no está hecho. La
+inclusión trae sus propios desafíos.
+
+Para empezar, la visibilidad de su parche ha aumentado una vez más. Puede
+haber una nueva ronda de comentarios de desarrolladores que no estaban al
+tanto del parche antes. Puede ser tentador ignorarlos, ya que ya no hay
+cuestión de que su código sea fusionado. Sin embargo, resista esa
+tentación; aún necesita ser receptivo a los desarrolladores que tienen
+preguntas o sugerencias.
+
+Más importante aún, la inclusión en la línea principal pone su código en
+manos de un grupo mucho más grande de probadores. Incluso si ha contribuido
+un driver para hardware que aún no está disponible, se sorprenderá de
+cuántas personas construirán su código en sus kernels. Y, por supuesto,
+donde hay probadores, habrá informes de errores.
+
+El peor tipo de informes de errores son las regresiones. Si su parche causa
+una regresión, encontrará un número incómodo de ojos sobre usted; las
+regresiones pueden dar lugar a mucho malestar en la comunidad y pueden
+hacer que algunos desarrolladores comiencen a preguntarse si su parche
+realmente debería haber sido fusionado en primer lugar. Así que esté atento
+a los comentarios sobre problemas y, si es posible, corrija los errores de
+inmediato.
+
+Después de haber abordado cualquier regresión, puede haber otros errores
+ordinarios que resolver. El período de estabilización es su mejor
+oportunidad para corregir estos errores y garantizar que el debut de su
+código en una versión del kernel principal sea lo más sólido posible. Así
+que, por favor, responda a los informes de errores y solucione los
+problemas si es posible. Para eso es el período de estabilización; puede
+comenzar a crear parches nuevos y geniales una vez que se hayan resuelto
+los problemas de los antiguos.
+
+Y no olvide que hay otros hitos que también pueden generar informes de
+errores: la próxima versión estable del kernel principal, cuando
+distribuidores prominentes adopten una versión del kernel que contenga su
+parche, etc. Continuar respondiendo a estos informes es una cuestión de
+orgullo básico en su trabajo. Sin embargo, si eso no es suficiente
+motivación, también vale la pena considerar que la comunidad de desarrollo
+recuerda a los desarrolladores que pierden interés en su código después de
+que se fusiona. La próxima vez que publique un parche, lo evaluarán con la
+suposición de que no estará disponible para mantenerlo después.
+
+Otras cosas que pueden suceder
+-------------------------------
+
+Un día, puede que abra su cliente de correo y vea que alguien le ha enviado
+un parche para su código. Esa es una de las ventajas de tener su código
+disponible públicamente, después de todo. Si está de acuerdo con el parche, puede reenviarlo al maintainer del subsistema (asegúrese de incluir una
+línea From: adecuada para que la atribución sea correcta, y añada su propia
+firma), o enviar una respuesta Acked-by: y dejar que el autor original lo
+envíe hacia arriba.
+
+Si no está de acuerdo con el parche, envíe una respuesta educada explicando
+por qué. Si es posible, dígale al autor qué cambios deben hacerse para que
+considere el parche aceptable. Existe una cierta resistencia a incluir
+parches que son rechazados por el autor y el maintainer del código, pero
+esto tiene un límite. Si se interpreta que bloque buen trabajo, esos
+parches eventualmente lo eludirán y se incorporarán al kernel de todos
+modos. En el kernel de Linux, nadie tiene poder de veto absoluto sobre
+ningún código. Excepto quizás Linus.
+
+En muy raras ocasiones, puede encontrar algo completamente diferente: otro
+desarrollador publica una solución distinta a su problema. En ese punto, es
+probable que uno de los dos parches no se incluya, y "el mío fue el
+primero" no se considera un argumento técnico convincente. Si el parche de
+otra persona desplaza al suyo y se incorpora al kernel, realmente solo hay
+una manera de responder: alegrarse de que su problema se haya resuelto y
+continuar con su trabajo. Que su trabajo sea desplazado de esta manera
+puede ser doloroso y desalentador, pero la comunidad recordará su reacción
+mucho después de que hayan olvidado de quién era el parche que realmente se
+incluyó.
diff --git a/Documentation/translations/sp_SP/process/development-process.rst b/Documentation/translations/sp_SP/process/development-process.rst
index fa078a18c1a7..c977d047a792 100644
--- a/Documentation/translations/sp_SP/process/development-process.rst
+++ b/Documentation/translations/sp_SP/process/development-process.rst
@@ -28,3 +28,4 @@ para entenderla.
    3.Early-stage
    4.Coding
    5.Posting
+   6.Followthrough
-- 
2.43.0


